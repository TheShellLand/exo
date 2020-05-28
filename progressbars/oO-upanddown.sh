progress()
{
  tput civis
  echo -ne '\r'
  tput el
  sleep 0.2
  echo -ne '\r.'
  sleep 0.2
  echo -ne '\r.o'
  sleep 0.2
  echo -ne '\r.oO'
  sleep 0.5
  echo -ne '\r.o'
  tput el
  sleep 0.2
  echo -ne '\r.'
  tput el
  sleep 0.2
  echo -ne '\r'
  tput el
  sleep 0.2
  tput cnorm
}
