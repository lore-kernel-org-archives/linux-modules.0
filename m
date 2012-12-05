Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Wed, 5 Dec 2012 01:52:57 -0200
Message-ID: <CAMOw1v6gc-NV8M8cHX9novwDv57zWMtoLHn6P22GGJ0QW2wFww@mail.gmail.com>
Subject: [ANNOUNCE] kmod 12
To: linux-modules <linux-modules@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-hotplug <linux-hotplug@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

kmod 12 is out:

ftp://ftp.kernel.org/pub/linux/utils/kernel/kmod/kmod-12.tar.xz
ftp://ftp.kernel.org/pub/linux/utils/kernel/kmod/kmod-12.tar.sign


Bug fix release only. Copying the NEWS section here for brevity:

       - Fix removing vermagic from module when told to force load a module
       - Fix removing __versions section when told to force load a module: we
         need to mangle the section header, not the section.
       - modinfo no longer fails while loading a module from file when path
         contains ".ko" substring

Interesting that there was no previous bug report of "modprobe -f"
failing, yet before this release it was not working properly. Maybe
people are not tainting their kernel as frequently as I imagined.

Shortlog is below.


Cheers
Lucas De Marchi

---

Aleksey Makarov (1):
      fix is_module_filename()

Lucas De Marchi (7):
      depmod: fix hash lookup by relpath instead of uncrelpath
      depmod: fix asserting mod->kmod == NULL
      libkmod-module: Remove key+value vermagic from .modinfo section
      libkmod-module: mangle the section header, not the section
      Use bool instead of int
      depmod: fix checking file extension
      kmod 12
