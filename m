Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:32804 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbbHGJb6 (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 7 Aug 2015 05:31:58 -0400
Received: by wijp15 with SMTP id p15so53109837wij.0
        for <linux-modules@vger.kernel.org>; Fri, 07 Aug 2015 02:31:57 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 7 Aug 2015 05:31:57 -0400
Message-ID: <CANULwrQY+_Bv1r9V2FsVP=+ODSDVLsDicD+sBwcJYrZz60vCFQ@mail.gmail.com>
Subject: fnmatch for modprobe.d "options" commands?
From: Ari Entlich <atrigent@gmail.com>
To: linux-modules@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

I am trying to do some debugging of a sound issue, and in the process
I am having to use the "dynamic debug" feature of the kernel. I would
like to enable all debug messages for all of the sound modules on my
system. Once all of the modules are loaded, I can do this:

echo 'module snd* +p' > /sys/kernel/debug/dynamic_debug/control

However, by the time I do this, most of the messages that would have
happened have already happened. There is a module argument "dyndbg"
which can be used to set dynamic debug flags for a module, which will
obviously take effect immediately once the module has loaded. However,
in order to do the same thing that I am doing with the control file
above, I'd have to add options commands to my modprobe.d files for
each sound module on my system, or at least for each one which I know
will be loaded. Ideally, I'd like to be able to do this:

options snd* dyndbg="+p"

>From my reading of the kmod source code, it looks like enabling this
sort of thing would be a very trivial patch to the
kmod_module_get_options function in libkmod-module.c. Furthermore, it
looks like other modprobe.d commands (install, softdep, and remove)
are already using fnmatch for the module name. Would it be possible to
add the options command to that list?

Whether this change is made or not, it might be a good idea to update
the documentation to reflect the fact that fnmatch is being used for
some of the commands.

Thanks!

Ari
