Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F95F3644C6
	for <linux-modules@vger.kernel.org>; Tue, 17 Mar 2026 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773751864; cv=none; b=X/EEWEskM6T3ZB4NNA9k3PQ1ihKwYSZ9E2Pf7ucZ5soKu/g3UCOwN1lpQryss7a8L7ZcmGXIJXGFoSJc8IQJ4Axde/l6IRO9fhCs8G/LE27l1t7EW9exdG1V/29jgX2YMI9gOu8qvTV0PIFaNwqXuTWcvBi87UDsxID1sFnYEPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773751864; c=relaxed/simple;
	bh=9x4rSJQhtKV4SnOioksCqGOgd6yo22HmDkvguE0dioE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=meAdSydTcqTcUntT8oKYM8PqgMh8CGgaHMfDoHAtOqdxVoME6rNLaNVDV8+ufDHsgsckzfobE8xRr008FoVy24ycQ2wIDVhgPbEUhWQy02KsaDe2vA4+ZY6PNPcjF4qSVKucrhIQCTrhHIzmRfiJ5ONkiuwYRPjJmoie4F2j66w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZwDWtvNn; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZwDWtvNn"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-485345e1013so5686915e9.1
        for <linux-modules@vger.kernel.org>; Tue, 17 Mar 2026 05:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773751861; x=1774356661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z9FF3jptzwdTviK++wQdCMhUD9QB9yKDmCDYs1F27lA=;
        b=ZwDWtvNn7cEEFWUmjhJPSKp/7PwWA/UpqoKksqEcLxVkRQhF3fUOKxNHCGI91TWuBU
         rcTo0m40iwDc1Dbh1AZkafj6St6fFrjqAA5wJXM/u9ZNvgw2u7x66JG6JZAHz9oly75W
         FSYXKGw1fVvscn6GPGiz+r7yWNxTZ8/1E7Cf8kQXQaEFP9Na0xN5FE5cQWwHLWrRaAeA
         Jf0/seGTY38yD0U9Cj++TIlUm6nBNAwvwmEgn9BZ5fhXM1tOr8DpJeipGI5MDuPw1KXA
         NGFJ60JGvRaqdzxsriCsOJ2Ep84yRG/pFXHgAAMXS8LmR/rmFgFjrwL7fc9ebMSuK9SE
         AuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773751861; x=1774356661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z9FF3jptzwdTviK++wQdCMhUD9QB9yKDmCDYs1F27lA=;
        b=UtkguM4sCCM5YLMdI1GPKr4dCADDPSo0dVulZM3OThjdmG/EbxNVGAGuKx9IViPUW/
         NPLDzoz/KqGGjupxhl5yDYJGxl+O+PcPv8xQ6o76wVMz2Y9J2tLx2VXhp5zFQXDPfH/J
         QsjS7Sy/aCKT2tf2gxtg74v9NOR+8IQW89UpI9rVKLeBAXuCFvg6OLo10lR3qkGWA51s
         1rG+5gxGkWbJH4Ti83hwbhL2WRpjIOmoJ9aIubCErrvx5VVlOc4Bp2Qpv9mkFbYxgQH0
         mTp1TJ5nWzleZphy+Gjzfyxhz0JC7jELQw933QuraZhHA2foiCEUtyA6zHl6cn4XXKXV
         axsw==
X-Gm-Message-State: AOJu0YxTrtbPrHPtz4dXUPqTwBgdiCFernkT+MVaX8VBV5Wh3yA+hAMa
	jPXIOT6GS7n2IgmF1BufUGhoB7H2mra686yOT9h6//5qyeUakpi1QDErfHck/yGsgAt2ZEFCqGq
	4Khvl
X-Gm-Gg: ATEYQzzL41hnv3o/zGqXYF7RrbDg1SBI958po9JhwGb3D8d/dNHn+Tp/kP5mdbi5Vpm
	+saqfAzS1ySrDEToyaV4rKUoT7+A/6r61S376cfVetqikQuEeuFLy1XBhcMJqzAKlqSlaSM77JI
	W8mxOdA8W2u4LpihJKWgYBdjfh/L2ObjTsT8Afy6U2a1I6syjSmA5CSalKffYadkHb9+RcuBYyf
	3zqXDzQYfG0iLk+h3w0ydfCX2RXbilEQ2nZNO3R8wlPmoU43xfmL82KpD5iQcIbdlubruP1PFW5
	eQQMoX8w/P8BpfX0HOLGMpLLM5N+Vurz49Ov5RqIDIdmMcQWqx3GU7bbhzxlch1/G6NbQLiZXZb
	u7jawqNZ45BhDGSWCFpENRwKr0KoW+Yg0HzgAmFBhyGFtdVFgGahWplnC/Xc0yCktJV/1TUedoF
	dr6jYPRNixfeLN9nArKinzz6/QwGOdE3AUW/BSP40em1ZlYG+/RhDyILU=
X-Received: by 2002:a05:600c:8488:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-4856eadba01mr53496405e9.15.1773751860635;
        Tue, 17 Mar 2026 05:51:00 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48634a7ac2csm32740025e9.1.2026.03.17.05.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 05:51:00 -0700 (PDT)
Message-ID: <bbfaa9ab-8bfb-46a2-ba90-f6c19782e66d@suse.com>
Date: Tue, 17 Mar 2026 13:50:59 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: remove MODULE_VERSION()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Shyam Saini <shyamsaini@linux.microsoft.com>, Kees Cook <kees@kernel.org>,
 Thorsten Blum <thorsten.blum@linux.dev>,
 Christoph Hellwig <hch@infradead.org>
References: <2026031341-evolve-repeater-987b@gregkh>
 <d622c70a-f79a-4215-84fb-c5de0a8f6ce5@suse.com>
 <2026031630-linseed-powdered-a0d1@gregkh>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <2026031630-linseed-powdered-a0d1@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/26 11:03 AM, Greg Kroah-Hartman wrote:
> On Mon, Mar 16, 2026 at 10:37:38AM +0100, Petr Pavlu wrote:
>> On 3/13/26 3:20 PM, Greg Kroah-Hartman wrote:
>>> Module "versions" do not make sense as the kernel is built all at once,
>>> the "version" is the overall kernel version number, so modules can not
>>> really be described as having a unique version given that they rely on
>>> the infrastructure of the whole kernel.
>>>
>>> For now, just make this an "empty" define, to keep existing code
>>> building properly as the tree is slowly purged of the use of this over
>>> time.
>>>
>>> This macro will be removed entirely in the future when there are no
>>> in-tree users.
>>
>> I share a similar sentiment that module versions set by MODULE_VERSION()
>> are not particularly useful for in-tree modules and the macro is often
>> used unnecessarily. However, I don't think this patch takes the best
>> approach to phase it out.
>>
>> The file Documentation/ABI/stable/sysfs-module documents
>> /sys/module/<MODULENAME>/version as a stable ABI. Searching for
>> '^MODULE_VERSION' in v7.0-rc4 shows 600 uses of the macro. My concern is
>> that if any of these modules has a userspace part that checks the
>> version, this patch could potentially break users' systems.
> 
> sysfs use is ALWAYS "if the file is not there, the userspace tool should
> keep working".  How would userspace every do something different if a
> module version flag is not there, that is not how a kernel driver should
> ever be attempting to communicate with userspace as to what the api is,
> or is not.
> 
> And as the module version does not even work for any stable kernel
> release, it's kind of proof that userspace does not rely on this.

Makes sense. I have now also reviewed updates of MODULE_VERSION()
invocations going back 5 years and my impression is that removing this
macro should be generally safe.

New instances of MODULE_VERSION() are typically introduced when a new
driver is added to the codebase.

There were numerous commits where MODULE_VERSION() is removed with the
argument that it is unnecessary for in-tree modules and that the main
kernel version should be used instead. This suggest that there is
already a broader consensus that module versions are not particularly
useful, at least not for in-tree modules.

There was a limited number of cases where a per-module version is
actually updated. Examples:

ea7af9454815 ("platform/x86: dell_rbu: Bump version")
93d09773d1a5 ("xz: add RISC-V BCJ filter")
98d5b61ef5fa ("coda: bump module version to 7.2")
8cb5d216ab33 ("char: xillybus: Move class-related functions to new xillybus_class.c")
74f46a0524f8 ("scsi: fnic: Turn off FDMI ACTIVE flags on link down")
6cd379f75f42 ("ata: pata_hpt3x2n: pass base DPLL frequency to hpt3x2n_pci_clock()")
47adef20e67d ("pata: ixp4xx: Rewrite to use device tree")

(The last three commits are indirect updates, where the module contains
MODULE_VERSION(DRV_VERSION); and DRV_VERSION is updated.)

Most of these version bumps do not seem particularly noteworthy. Only
commit 98d5b61ef5fa appears somewhat interesting with the description:

    coda: bump module version to 7.2

    Helps with tracking which patches have been propagated upstream and if
    users are running the latest known version.

> 
>> I believe it would be safer to start by removing individual uses of
>> MODULE_VERSION(). That way, we can also learn if we're missing any use
>> cases for having module versions.
> 
> Sure, I'll make up a patch to drop all 700 uses, but how is that much
> different?  :)

The end result is ultimately the same. The kernel will no longer have
any uses of MODULE_VERSION() or its implementation.

The difference is that by removing the uses of MODULE_VERSION() first,
the maintainers of the relevant code will be properly informed about
this change, rather than being told afterwards, when they will no longer
have a chance to provide any feedback.

Another aspect is that MODULE_VERSION() still appears useful for
external modules. Sure, we won't keep this macro if all uses in the
kernel are removed and these external modules will need to replace it
with a different mechanism. However, changing MODULE_VERSION() now to
only a dummy implementation can silently break version tracking for
these modules, which is not ideal.

If I end up being the only one who prefers removing the invocations of
this macro first, then please at least CC a few more lists on v2 of the
patch, such as driver-core and netdev, as well as the authors of the
recent version-bump commits that I identified above.

> 
>> The original patch "Add a MODULE_VERSION macro" [1] from 2004 doesn't
>> say much about the motivation for adding module versions, but it does
>> mention that they should be accessible via sysfs.
> 
> That was because we were just exporting all of the module information in
> sysfs, not due to us attempting to do anything special with that info in
> userspace other than "hey we have an attribute, let's export it!"
> 
>> That was implemented
>> a year later in commit c988d2b28454 ("[PATCH] modules: add version and
>> srcversion to sysfs") [2], which primarily discusses use cases related
>> to DKMS, and to administrators + tech support needing to know what is
>> actually loaded on the system. For the latter, I believe srcversion (or
>> something similar) should be sufficient.
> 
> And does dkms actually do anything with this sysfs value?  At quick
> glance, I couldn't see anything.

I'm not familiar with DKMS. From a quick look, it parses both the
version and srcversion, although it calls modinfo and doesn't read the
values from sysfs. See get_module_verinfo() and compare_module_version()
in dkms.in [1].

[1] https://github.com/dkms-project/dkms/blob/2c35ae1d32eb6377ef8e8dd7e15427d56b63828d/dkms.in#L983

-- 
Thanks,
Petr
