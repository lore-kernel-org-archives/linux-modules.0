Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40983 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754079AbbFCME1 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Wed, 3 Jun 2015 08:04:27 -0400
Message-ID: <556EED48.6010804@suse.cz>
Date: Wed, 03 Jun 2015 14:04:24 +0200
From: Michal Marek <mmarek@suse.cz>
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>, Andreas Mohr <andi@lisas.de>
CC: Andrew Morton <akpm@linux-foundation.org>,
	Bertrand Jacquin <beber@meleeweb.net>,
	Marco d'Itri <md@linux.it>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH] modules: CONFIG_MODULE_COMPRESS: add hint that userspace
 support may easily be missing.
References: <20150531152932.GA16337@rhlx01.hs-esslingen.de> <87r3pwgd0b.fsf@rustcorp.com.au>
In-Reply-To: <87r3pwgd0b.fsf@rustcorp.com.au>
Content-Type: text/plain; charset=windows-1252
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On 2015-06-01 08:26, Rusty Russell wrote:
> Andreas Mohr <andi@lisas.de> writes:
>> Hi,
>>
>> I just had a not so nice experience
>> when finally upgrading to a new 4.1-rc5
>> with CONFIG_MODULE_COMPRESS newly enabled -
>> userspace binary parts (kmod 18 or 20 in my case)
>> did not have compression enabled
>> (at least on Debian 8pre, vs. encountering it enabled on FC21)
>> since it does not seem to be
>> the default build configuration of kmod (yet?).
> 
> Sure.  Let's get the maintainers to insert the actual version required
> in the help text though.

I'm not a maintainer of kmod, but the text should probably end with "If
unsure, say N."

Michal
