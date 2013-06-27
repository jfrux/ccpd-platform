#!/bin/bash
ssh ccpdtest@mccme-web.msbb.uc.edu << EOF
  cd public_html
  git pull
EOF