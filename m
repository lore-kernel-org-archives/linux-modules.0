Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59552 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276AbaCFRTI (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Thu, 6 Mar 2014 12:19:08 -0500
Message-ID: <5318AE0B.7050308@suse.cz>
Date: Thu, 06 Mar 2014 18:19:07 +0100
From: Michal Marek <mmarek@suse.cz>
MIME-Version: 1.0
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	linux-modules@vger.kernel.org
Subject: Re: [PATCH 6/8] build-sys: Do not require xsltproc for installation
 of man pages
References: <1394114809-2737-1-git-send-email-lucas.demarchi@intel.com> <1394114809-2737-6-git-send-email-lucas.demarchi@intel.com>
In-Reply-To: <1394114809-2737-6-git-send-email-lucas.demarchi@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On 2014-03-06 15:06, Lucas De Marchi wrote:
> Same reason as found in this commit to systemd:
> 
> 	commit 4ca39b280fce3c60d2fdecbd478fd9bf7f9d3e64
> 	Author: Mike Gilbert <floppym@gentoo.org>
> 	Date:   Sun Feb 23 11:21:13 2014 -0500
> 
> 	    configure: Do not require xsltproc for installation of man pages

Great, it will be possible to build a package without requiring xsltproc.

Thanks,
Michal
