#!/bin/bash
openssl aes-256-cbc -K $encrypted_532cd7f1946c_key -iv $encrypted_532cd7f1946c_iv -in $(pwd)/.deploy/travis_id_rsa.enc -out $(pwd)/.deploy/travis_id_rsa -d

chmod 0400 $(pwd)/.deploy/travis_id_rsa

ssh -t -oStrictHostKeyChecking=no -i $(pwd)/.deploy/travis_id_rsa travis@jersey1.rkeplin.com 'sed -i "s/image: rkeplin\/bible-go-api:[a-zA-Z0-9]*/image: rkeplin\/bible-go-api:'"$TRAVIS_BUILD_NUMBER"'/g" /opt/stacks/bible.yml'
ssh -t -oStrictHostKeyChecking=no -i $(pwd)/.deploy/travis_id_rsa travis@jersey1.rkeplin.com 'docker stack deploy -c /opt/stacks/bible.yml bible'

rm -rf $(pwd)/.deploy/travis_id_rsa
