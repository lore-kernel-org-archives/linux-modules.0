Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mail1.sysgo.com ([176.9.26.183]:51171 "EHLO mail1.sysgo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799AbaBZIZ5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Wed, 26 Feb 2014 03:25:57 -0500
From: Andrej Krutak <andrej.krutak@sysgo.com>
To: linux-modules@vger.kernel.org
Subject: modprobe documentation discrepancy (modules.dep support)
Date: Wed, 26 Feb 2014 09:18:43 +0100
Message-ID: <1627264.ihO3vEG55s@kru>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Hi,

the modprobe documentation states that:

%<--------
modprobe expects an up-to-date modules.dep.bin file (or fallback human 
readable modules.dep file)
%<--------

but in reality no fallback happens in the current code. module-init-tools did 
the fallback, so I suppose this is a leftover from the previous documentation.

I guess the simplest thing to do would be removing the documentation. On the 
other hand the depmod.pl script (from ltib.org) doesn't create the binary 
file, so not supporting "legacy" modules.dep breaks some stuff...

-- 
Best regards | S pozdravom | Mit freundlichen Gr��en | Cordialement

Andrej Krutak
SYSGO

