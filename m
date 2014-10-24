Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:59772 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756586AbaJXMnP (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 24 Oct 2014 08:43:15 -0400
Date: Fri, 24 Oct 2014 14:43:01 +0200
From: Holger Eitzenberger <holger@eitzenberger.org>
To: jcm@jonmasters.org, linux-modules@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sebastian.poehn@sohpos.com
Subject: Regression using module-init-tools on Kernel v3.12.y
Message-ID: <20141024124301.GA9396@imap.eitzenberger.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Hi all,

we are still using module-init-tools for module handling.  And so does
SuSE SLES11.

However, after upgrading from kernel v3.8.y to v3.12.y we noticed
that modules.pcimap was empty, which is due to the fact that the
DEFINE_PCI_DEVICE_TABLE() has been modified to encode the name of
the device table.  Which in turn has been done to avoid issues with
multiple tables in a driver (see [1]).

I understand why this patch went it, and fixing this issue in the PNP
driver is worth fixing, I agree.

However, there is quite some userbase of module-init-tools out there,
eventually upgrading as well.  And as a consequence I think it makes
sense to patch module-init-tools as well to support both format.

I know that module-init-tools are deprecated by libkmod, and therefore
they seem to be unmaintained since 2011 (at least when looking at
git.kernel.org).

Still, does the attached patch makes sense to apply to git GIT repo?
It modifies elfops to support old and new format of the table name.

I think most people will check kernel.org GIT for a patch, so I think
it makes sense to apply this patch.

Thanks.

 /Holger


[1] http://marc.info/?l=linux-input&m=139091653012772&w=2
