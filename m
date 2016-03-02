Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from attila.bofh.it ([85.94.204.146]:54130 "EHLO attila.bofh.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752448AbcCBRKa (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Wed, 2 Mar 2016 12:10:30 -0500
Date: Wed, 2 Mar 2016 18:10:20 +0100
To: "De Marchi, Lucas" <lucas.demarchi@intel.com>
Cc: "lkundrak@v3.sk" <lkundrak@v3.sk>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] modprobe: install default configuration
Message-ID: <20160302171020.GA9719@bongo.bofh.it>
References: <1456931893-13545-1-git-send-email-lkundrak@v3.sk>
 <20160302155551.GA31679@bongo.bofh.it>
 <1456934860.3200.4.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456934860.3200.4.camel@intel.com>
From: md@Linux.IT (Marco d'Itri)
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Mar 02, "De Marchi, Lucas" <lucas.demarchi@intel.com> wrote:

> Marco, could you be more specific on how this breaks userspace? It
It breaks the expectation that loading the module will make dummy0 
appear.
But if there is an agreement that this should be changed then I believe
that it should be changed in the kernel to be sure to have the same 
default across different distributions.

-- 
ciao,
Marco
