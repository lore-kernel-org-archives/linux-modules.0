Return-Path: <lucas.de.marchi@gmail.com>
From: lucas.de.marchi@gmail.com
To: linux-modules@vger.kernel.org
Cc: Rusty Russell <rusty@rustcorp.com.au>,
	Andreas Mohr <andi@lisas.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bertrand Jacquin <beber@meleeweb.net>,
	Marco d'Itri <md@linux.it>,
	lkml <linux-kernel@vger.kernel.org>,
	Kay Sievers <kay@vrfy.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH kmod 0/3] Add feature list together with version
Date: Sun,  7 Jun 2015 03:27:26 -0300
Message-Id: <1433658449-3931-1-git-send-email-lucas.de.marchi@gmail.com>
List-ID: <linux-modules.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@intel.com>

Sample output:

$ ./tools/kmod --version
kmod version 20
+XZ +ZLIB -EXPERIMENTAL

Lucas De Marchi (3):
  build: add function to build string of features
  build: add relevant features to KMOD_FEATURES in config.h
  tools: display features together with version information

 configure.ac     |  7 +++++++
 m4/features.m4   | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 tools/depmod.c   |  1 +
 tools/insmod.c   |  1 +
 tools/kmod.c     |  1 +
 tools/modinfo.c  |  1 +
 tools/modprobe.c |  1 +
 tools/rmmod.c    |  1 +
 8 files changed, 61 insertions(+)
 create mode 100644 m4/features.m4

-- 
2.4.2
