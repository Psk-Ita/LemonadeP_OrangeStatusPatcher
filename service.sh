#!/system/bin/sh
MODDIR=${0%/*}

MODEL=$(getprop ro.product.model)
SLOT=$(getprop ro.boot.slot_suffix)

FILE=$MODDIR/$MODEL/abl.img

if [ -f "$FILE" ]; then
  echo >$MODDIR/disable
  
  echo "Good News!"
  echo "detected model $MODEL, active slot is $SLOT..."
  echo
  echo "let's patch it!"
  $`dd if=$FILE of=/dev/block/by-name/abl$SLOT ;`;
  echo
else
  echo >$MODDIR/delete
  
  echo "Sorry: $MODEL is not supported. No action executed"
  echo
  echo "Module will self-delete on next boot"
  echo
fi

echo
echo "Enjoy!"
