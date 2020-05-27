progress()
{
  tput civis
  echo -ne '\r.'
  sleep 0.2
  echo -ne '\r.o'
  sleep 0.2
  echo -ne '\r.oO'
  sleep 0.5
  echo -ne '\r.o '
  sleep 0.2
  echo -ne '\r.  '
  sleep 0.2
  echo -ne '\r   '
  sleep 0.2
  tput el
}
