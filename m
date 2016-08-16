Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from fmap.me ([91.92.66.84]:33936 "EHLO smtp.fmap.me"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752472AbcHPA6P (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Mon, 15 Aug 2016 20:58:15 -0400
From: Nikolay Amiantov <ab@fmap.me>
To: linux-modules@vger.kernel.org
Cc: Shea Levy <shea@shealevy.com>
Subject: Improvements in search of kernel modules directory
Date: Tue, 16 Aug 2016 03:50:28 +0300
Message-Id: <20160816005032.28881-1-ab@fmap.me>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

These series of patches add more control over how kernel modules directory is
found:

* Add an environment variable which allows to override kernel modules
  directory;
* Allow to hardcode several paths which are searched in order for `uname -r`
  subdirectory;
* Add a configure option to set those paths, instead of hardcoding
  /lib/modules.

We have used the first patch in NixOS[1] for a long time to point kmod to
kernel modules. While an environment variable is handy and has been solving our
problems, it doesn't cover all our cases. We have two directories:

* /run/current-system/kernel-modules/lib/modules
* /run/booted-system/kernel-modules/lib/modules

, which are symlinked to modules for current system configuration (i.e. after
an update) and the one which the system was booted with. It allows us to both
give users ability to install new modules and have their old kernel modules
accessible until a reboot (which is useful in case of kernel upgrade).

Before those patches the necessary logic (see if kernel modules for current
kernel version are available in current-system, if not then fall back to
booted-system) was implemented as a shell wrapper around kmod, which was
unwieldy and didn't work for applications that use kmod directly. It was
considered better to move this logic to kmod itself. Also, NixOS uses nixpkgs,
a set of distribution-agnostic packages (which run on e.g. Ubuntu and even Mac
OS X where applicable), so it was necessary to preserve /lib/modules as a
fallback directory in kmod for it to work on FHS distributions.

As a result a set of generic patches was written that implement necessary
behaviour while being potentially useful for upstream. Environment variable is
still used in several places (e.g. in automatic generation and running of
virtual machines) and is useful for us even with the rest of those patches.

A home of those patches can be found on GitHub[2] along with some
discussion, as can be related NixOS patches and discussion[3].

Big thanks to Shea Levy for the original patch, extensive code review and
useful advices.

Additionally, while working on those it was discovered that kmod makes use of
PATH_MAX. This constant is considered harmful[4] because it doesn't correspond
to real possible length of filesystem paths. This can be considered a bug, but
in those patches it was decided to follow upstream design decisions wherever
possible and so we also use it here.

[1]: http://nixos.org/
[2]: https://github.com/abbradar/kmod/
[3]: https://github.com/NixOS/nixpkgs/pull/17738/
[4]: http://insanecoding.blogspot.ru/2007/11/pathmax-simply-isnt.html

