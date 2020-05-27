progress()
{
  tput civis
  echo -ne '\r.'
  sleep 0.4
  echo -ne '\r.o'
  sleep 0.4
  echo -ne '\r.oO'
  sleep 0.4
  echo -ne '\r.o '
  sleep 0.4
  echo -ne '\r.  '
  sleep 0.4
  echo -ne '\r   '
  sleep 0.4
  tput el
}
