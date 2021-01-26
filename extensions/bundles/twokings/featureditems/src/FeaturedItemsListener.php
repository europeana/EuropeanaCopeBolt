<?php

namespace Bolt\Extension\TwoKings\FeaturedItems;

use Bolt\Events\StorageEvent;
use Bolt\Events\StorageEvents;


/**
 * An extension for managing featured items.
 *
 * @author Lodewijk Evers <lodewijk@twokings.nl>
 */
class FeaturedItemsListener
{
  private $app;
  private $config;

  public function __construct(\Bolt\Application $app, $config) {
    $this->app = $app;
    $this->config = $config;
  }

  /**
   * StorageEvent::PRE_SAVE event callback.
   *
   * @param StorageEvent $event
   */
  public function onItemSave(StorageEvent $event)
  {
    // Do something with the event.
    $itemtype = $event->getContentType();

    if($this->isContentTypeFeatured($itemtype)) {
      $itemcontent = $event->getContent();
      $currenttypeconfig = $this->config['contenttypes'][$itemtype];

      $itemid = $itemcontent->get('id');
      $itemfeaturedstatus = $itemcontent->get('featured');

      if($itemfeaturedstatus == 1) {
        $this->deFeatureOtherItems($currenttypeconfig, $itemtype, $itemid);
      } else {
        $this->deFeatureCurrentItem($currenttypeconfig, $itemtype, $itemid);
      }
    }
  }

  /**
   * Unset featured flag for current item
   *
   * @param $currenttypeconfig
   * @param $itemtype
   * @param $itemid
   */
  function deFeatureCurrentItem($currenttypeconfig, $itemtype, $itemid) {
    if ($currenttypeconfig['maxfeatured'] > 1) {
      // don't use the native bolt item save, because that will trigger the storage save event again
      // get content type table from bolt
      $prefix = $this->app['config']->get('general/database/prefix');
      $table = $this->app['config']->get(
        'contenttypes/' . $itemtype . '/tablename'
      );
      $tablename = $prefix . $table;

      // get the field from the config
      $featuredfield = ($currenttypeconfig['field']) ?
        $currenttypeconfig['field'] : 'featured';

      // assume the row identifier field is named id
      $db = $this->app['db'];

      // check if current item was featured
      $qb = $db->createQueryBuilder();
      $qb->select($featuredfield)
        ->from($tablename)
        ->where('id = ?')
        ->setParameter(0, $itemid);
      $r0 = $qb->execute();
      $post0 = $r0->fetch();

      if(array_key_exists('featured', $post0) && $post0[$featuredfield] == 1) {
        // item was featured
        // 'UPDATE %contentype SET %featured = 0 WHERE id = %itemid';
        $qb1 = $db->createQueryBuilder();
        $qb1->update($tablename)
          ->set($featuredfield, 0)
          ->where(
            $qb1->expr()->eq('id', $itemid)
          )
        ;
        $r1 = $qb1->execute();

        // decrease featured flag for all featured items.
        // 'UPDATE %contentype SET %featured =  %featured + 1 WHERE %featured > 0 AND id != %itemid';
        $qb2 = $db->createQueryBuilder();
        $qb2->update($tablename)
          ->set($featuredfield, $featuredfield . '-1')
          ->where(
            $qb2->expr()->gt($featuredfield, 1)
          )
        ;
        $r2 = $qb2->execute();

      }
    }
    return 1;
  }

  /**
   * Unset featured flag for other items
   *
   * @param $currenttypeconfig
   * @param $itemtype
   * @param $itemid
   */
  function deFeatureOtherItems($currenttypeconfig, $itemtype, $itemid) {
    if($currenttypeconfig['maxfeatured'] == 0) {
      return 1;
    } else {
      // don't use the native bolt item save, because that will trigger the storage save event again
      // get content type table from bolt
      $prefix = $this->app['config']->get('general/database/prefix');
      $table = $this->app['config']->get('contenttypes/'.$itemtype.'/tablename');
      $tablename = $prefix . $table;

      // get the field from the config
      $featuredfield = ($currenttypeconfig['field']) ?
        $currenttypeconfig['field'] : 'featured';

      // assume the row identifier field is named id

      $db = $this->app['db'];

      // check if current item was featured
      $qb0 = $db->createQueryBuilder();
      $qb0->select($featuredfield)
        ->from($tablename)
        ->where('id = ?')
        ->setParameter(0, $itemid);
      $r0 = $qb0->execute();
      $post0 = $r0->fetch();

      // if it was featured - do nothing
      if(array_key_exists('featured', $post0) && $post0[$featuredfield] == 1) {
        return 1;
      }

      if ($currenttypeconfig['maxfeatured'] === 1) {
        //$query = 'UPDATE %contentype SET %featured = 0 WHERE id != %itemid';
        $qbonly = $db->createQueryBuilder();
        $qbonly->update($tablename)
          ->set($featuredfield, 0)
          ->where(
            'id != ' .  $qbonly->createNamedParameter($itemid)
          );
        return $qbonly->execute();
      }
      else {

        // increment all featured posts except the current one
        //'UPDATE %contentype SET %featured =  %featured + 1 WHERE %featured > 0 AND id != %itemid';
        $qb1 = $db->createQueryBuilder();
        $qb1->update($tablename)
          ->set($featuredfield, $featuredfield . '+1')
          ->where(
            $qb1->expr()->andX(
              $qb1->expr()->gt($featuredfield, 0),
              $qb1->expr()->neq('id', $itemid)
            )
          )
        ;
        $r1 = $qb1->execute();

        // kill all featured posts that were featuree flags are too old
        // 'UPDATE %contentype SET %featured = 0 WHERE %featured > %maxfeatured';
        $qb2 = $db->createQueryBuilder();
        $qb2->update($tablename)
          ->set($featuredfield, 0)
          ->where(
            $qb2->expr()->gt(
              $featuredfield,
              $currenttypeconfig['maxfeatured']
            )
          )
        ;
        $r2 = $qb2->execute();

        return 1;
      }
    }
  }

  /**
   * Check if the current type has an active configuration for featured items
   *
   * @param $type
   *
   * @return bool
   */
  function isContentTypeFeatured($type) {
    foreach($this->config['contenttypes'] as $key => $values) {
      if($type == $key && $values['hasfeatured'] === true) {
        return true;
      }
    }
    return false;
  }
}
