Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59573 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750829AbaCFRWV (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Thu, 6 Mar 2014 12:22:21 -0500
Message-ID: <5318AECC.1020404@suse.cz>
Date: Thu, 06 Mar 2014 18:22:20 +0100
From: Michal Marek <mmarek@suse.cz>
MIME-Version: 1.0
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	linux-modules@vger.kernel.org
Subject: Re: [PATCH 8/8] man: use systemd as example instead of udev
References: <1394114809-2737-1-git-send-email-lucas.demarchi@intel.com> <1394114809-2737-8-git-send-email-lucas.demarchi@intel.com>
In-Reply-To: <1394114809-2737-8-git-send-email-lucas.demarchi@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On 2014-03-06 15:06, Lucas De Marchi wrote:
> Nowadays udev doesn't create nodes in /dev anymore. This role is rather
                              ^static

As of writing this, udev still takes care of "normal" device nodes.

Michal
