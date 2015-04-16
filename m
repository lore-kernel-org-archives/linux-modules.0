Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from smnotes1.sieb-meyer.de ([213.252.170.194]:39241 "EHLO
	mail.sieb-meyer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964897AbbDPJln convert rfc822-to-8bit (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Thu, 16 Apr 2015 05:41:43 -0400
From: =?iso-8859-1?Q?H=E4nel-Baas=2C_Alexander?=
	<alexander.haenel-baas@sieb-meyer.de>
To: "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Subject: modules out of tree issue
Date: Thu, 16 Apr 2015 09:41:39 +0000
Message-ID: <9BA84827B30CBE4996725F98F7DC912342962FC2@SMExchange01.siebmeyer.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Hi,

I cross compile my own kernelmodule out of tree.
Now I changed the kernel to 3.18.1 and when I compile my own module I get the error:
-ld: no input files

The first call is the ld and not the compiler. This is the problem.

With kernel 3.14 and older always compiled good.

Is there any changes in the kernel makefile to build the kernel out of tree?
Any ideas?

I'm not sure is this the right group, sorry.

With best regards,
Alexander H�nel-Baas


