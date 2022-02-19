Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287E4C433EF
	for <linux-modules@archiver.kernel.org>; Sat, 19 Feb 2022 18:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242526AbiBSSl6 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sat, 19 Feb 2022 13:41:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbiBSSl5 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sat, 19 Feb 2022 13:41:57 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6465C3885
        for <linux-modules@vger.kernel.org>; Sat, 19 Feb 2022 10:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645296098; x=1676832098;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=91CTvnRgPFi6pesExLeCqtEV9j/Uf0vrqrRkeb7eWno=;
  b=VOk89WEsMf8opW3LtCBDiEP6PXMmwt41ixOOWR54wIM46Zo/NNqOqAdQ
   ERB2qDbliH24NV2IVMYvsvazYd+5P8XLy/O68S+n22k5kExdbeiU/WqU6
   D4sDb0NDJnt3jW9RKS+hXqGmBO8bZXtdkN6U1j1Hag7tdUS5uYO8opNRK
   exmiR6li9yAs8RebIizt2JOszTFfJi7014Hb0TGCgPMh5kTQxBsH9Py2y
   q9II1FamlucUhtXZUsadZ/W+gMlUX4q5i/j2CzmnVqSr9lCRpqRnu+8lO
   lLNEcgCwljpM0TWEBmVxKphZgN31nVJGnYVsW4FO6E5oqgpHse3rgVLwY
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10263"; a="275903989"
X-IronPort-AV: E=Sophos;i="5.88,381,1635231600"; 
   d="scan'208";a="275903989"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2022 10:41:38 -0800
X-IronPort-AV: E=Sophos;i="5.88,381,1635231600"; 
   d="scan'208";a="490003378"
Received: from penglin1-mobl.amr.corp.intel.com (HELO ldmartin-desk2) ([10.209.88.150])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2022 10:41:37 -0800
Date:   Sat, 19 Feb 2022 10:41:40 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH v2] libkmod: Prefer builtin index over builtin.alias
Message-ID: <20220219184140.koabdkufdxspccrh@ldmartin-desk2>
References: <CAKi4VAJs8mC23vpvkryrdJiX2fJgkPPzb763Og4Y0vZv_JH8Gw@mail.gmail.com>
 <20220213074335.15774-1-lucas.demarchi@intel.com>
 <20220213131339.yxi3rq3q6xexqbbx@example.org>
 <20220215074310.is2umkvdnsx5lk25@ldmartin-desk2>
 <20220219124042.th572glnwdivf2vw@example.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220219124042.th572glnwdivf2vw@example.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Sat, Feb 19, 2022 at 01:40:42PM +0100, Alexey Gladkov wrote:
>On Mon, Feb 14, 2022 at 11:43:10PM -0800, Lucas De Marchi wrote:
>> On Sun, Feb 13, 2022 at 02:13:39PM +0100, Alexey Gladkov wrote:
>> > On Sat, Feb 12, 2022 at 09:43:35PM -1000, Lucas De Marchi wrote:
>> > > The modules.builtin.alias.bin is way larger than the
>> > > modules.builtin.bin.  On a normal "distro kernel":
>> > >
>> > > 	21k modules.builtin.alias.bin
>> > > 	11k modules.builtin.bin
>> > >
>> > > >From the kernel we get both modules.builtin and modules.builtin.modinfo.
>> > > depmod generates modules.builtin.bin and modules.builtin.alias.bin
>> > > from them respectively. modules.bultin is not going away: it's not
>> > > deprecated by the new index added. So, let's just stop duplicating the
>> > > information inside modules.builtin.alias.bin and just use the other
>> > > index.
>> >
>> > The modules.builtin contains only module names. The modules.builtin.modinfo
>> > contains full info about builtin modules including names.
>> >
>> > I thought that if there is complete information about the modules, then
>> > reading the index with only the names does not make sense. And only in the
>> > absence of modules.builtin.modinfo, you need to fallback to the index
>> > with the names.
>>
>> yeah, but most of the time we really need only the module name, so we
>> can optimize for that. And since we are not getting rid of the other
>> index, we can simply use it first the same way that for modules we first
>> do lookup on lookup modules.dep and only later on modules.aliases.
>
>Yes and no. We can be sure that we don't need aliases. The argument passed
>to utilities can be very similar to the name of a module:
>
>$ modinfo fs-ext4
>name:           ext4
>filename:       (builtin)
>softdep:        pre: crc32c
>license:        GPL
>file:           fs/ext4/ext4
>description:    Fourth Extended Filesystem
>author:         Remy Card, Stephen Tweedie, Andrew Morton, Andreas Dilger, Theodore Ts'o and others
>alias:          fs-ext4
>alias:          ext3
>alias:          fs-ext3
>
>By the way, crc32c is also an alias:
>
>$ modinfo crc32c
>filename:       /lib/modules/5.14.0.61-centos-alt1.el9/kernel/arch/x86/crypto/crc32c-intel.ko
>alias:          crypto-crc32c-intel
>alias:          crc32c-intel
>alias:          crypto-crc32c
>alias:          crc32c
>license:        GPL
>description:    CRC32c (Castagnoli) optimization using Intel Hardware.
>author:         Austin Zhang <austin.zhang@intel.com>, Kent Liu <kent.liu@intel.com>
>rhelversion:    9.0
>srcversion:     1F2B6A533C8243A4017180A
>alias:          cpu:type:x86,ven*fam*mod*:feature:*0094*
>depends:
>retpoline:      Y
>intree:         Y
>name:           crc32c_intel
>vermagic:       5.14.0.61-centos-alt1.el9 SMP preempt mod_unload modversions
>
>This is because there are multiple implementations of crc32c. So, information
>about alias of builtin modules is almost always needed.

I was thinking about "optimization" related to libkmod/modprobe (which
is what matters during boot and for the systemd integration). Not for
modinfo which is only called by developers and auxiliary tools.
But then I measured it doing 50k random lookups. The speed up exists but
is under 1% and within the error margin, particularly because we need to
maintain the order doing the alias lookup first. So the main benefit is
really "we are not getting rid of the other index, so could as well just
not duplicate the info".

Another reason for not getting rid of the module is to be able to force
the lookup to be by module name, ignoring the alias. That was the reason
I sent this other series:
https://lore.kernel.org/linux-modules/Yg4DOfCUvIpDDBRd@bombadil.infradead.org/T/#t
so one can get the modinfo from the crc32 module, and not from its
aliases:

	$ modinfo --modname crc32
	module explicitly:
	name:           crc32
	filename:       (builtin)
	license:        GPL
	file:           lib/crc32
	description:    Various CRC32 calculations
	author:         Matt Domsch <Matt_Domsch@dell.com>

Lucas De Marchi
