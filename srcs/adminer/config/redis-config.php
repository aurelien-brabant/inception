<?php

////////////// REDIS CACHE CONFIGURATION //////////////

define( 'WP_REDIS_HOST', getenv('REDIS_HOST') );
define( 'WP_REDIS_PORT', getenv('REDIS_PORT') );
// define( 'WP_REDIS_PASSWORD', 'secret' );
define( 'WP_REDIS_TIMEOUT', 1 );
define( 'WP_REDIS_READ_TIMEOUT', 1 );

// change the database for each site to avoid cache collisions
define( 'WP_REDIS_DATABASE', 0 );

// supported clients: `phpredis`, `credis`, `predis` and `hhvm`
// define( 'WP_REDIS_CLIENT', 'phpredis' );

// automatically delete cache keys after 7 days
// define( 'WP_REDIS_MAXTTL', 60 * 60 * 24 * 7 );

// bypass the object cache, useful for debugging
// define( 'WP_REDIS_DISABLED', true );

?>
