#!/system/bin/sh
MODDIR=${0%/*}

# detect active slot
SLOT=$(getprop ro.boot.slot_suffix)
# detect device model
MODEL=$(getprop ro.product.model)
# detect current module name
MODNAME=$(grep "^id=" module.prop|cut -d'=' -f2)
# find model related abl from current module directory in magisk modules folder
FILE=$(find /data/adb ${MODNAME} | grep ${MODEL}/abl.img | head -n1)
echo
echo

if [ -f $FILE ]; then
  echo >$MODDIR/disable
  
  echo "  Good News!"
  echo "    detected model ${MODEL}, active slot is ${SLOT}..."
  echo
  echo "    let's patch it!"
  $`dd if=$FILE of=/dev/block/by-name/abl${SLOT} ;`;
else
  echo >$MODDIR/delete
  
  echo "  Sorry: $MODEL is not supported. No action executed"
  echo
  echo "    Module will self-delete on next boot"
fi

echo
echo
echo "Enjoy!"
