progress()
{
  tput civis
  echo -en "\r"
  tput el
  sleep 0.1
  echo -en "\rConnecting [o       ]"
  sleep 0.1
  echo -en "\rConnecting [ o      ]"
  sleep 0.1
  echo -en "\rConnecting [  o     ]"
  sleep 0.1
  echo -en "\rConnecting [   o    ]"
  sleep 0.1
  echo -en "\rConnecting [    o   ]"
  sleep 0.1
  echo -en "\rConnecting [     o  ]"
  sleep 0.1
  echo -en "\rConnecting [      o ]"
  sleep 0.1
  echo -en "\rConnecting [       o]"
  sleep 0.1
  echo -en "\rConnecting [      o ]"
  sleep 0.1
  echo -en "\rConnecting [     o  ]"
  sleep 0.1
  echo -en "\rConnecting [    o   ]"
  sleep 0.1
  echo -en "\rConnecting [   o    ]"
  sleep 0.1
  echo -en "\rConnecting [  o     ]"
  sleep 0.1
  echo -en "\rConnecting [ o      ]"
  sleep 0.1
  tput cnorm
}
