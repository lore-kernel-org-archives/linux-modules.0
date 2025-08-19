Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4877B1DC9B1
	for <linux-modules@vger.kernel.org>; Tue, 19 Aug 2025 08:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755593547; cv=none; b=JI1qc44nVCmTVedUiY9DyYA909W8XflKv35J2nIkjIs7F4UT39QcO/bSPSwiFKKj/p91Zaig89I0N0UQ7Y4JUgE/QAS+OVHyHdYTunedacL0nVFVe7EtA5R0+2v7742if59QvBLIkuhbjVkHBc+MGfPqwcaNGK1GpJH4tYDK158=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755593547; c=relaxed/simple;
	bh=YixifDKq1jWN99Ny/2mTRAmVRxRRr1pgF7b9TfJRVm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Evmh8PW4e4d/r4b/J7U3vXXzpr5CxfkSyU+AWi+W6tllGRnqKfTn2gidcLQqb0dBqSrfR9w6X4rHDz/gTKd3RA8UTqJ7WQDjlnhYaSZcrS1s67l8Fea4Vd3xsSIKONgTqWGNJ9oPihbB3X0kxA67uMJCFXLtnzeHzFRI5Uov8/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JzwW5wpx; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JzwW5wpx"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b9e41101d4so2639935f8f.2
        for <linux-modules@vger.kernel.org>; Tue, 19 Aug 2025 01:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755593543; x=1756198343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=meQtzR+ieVhgx/Q0wpHo6dmNc1XxiFtcKpS1QRJVYsY=;
        b=JzwW5wpxvgxVodkY2bgO4vBeroKleYZYxpR/M0cFo0vBwgbo/tqCJnTgf7dmVe+MZ5
         4uwBRkzPSShpVCHKqe7Wc4tBksfXZWVZYlnqN0Q9ezUpM6VJtxLV1Qgd+vLy54E8q/w4
         73i97Eg7DzssCf6fU8DbapnJgIN8p1HqVCeXBlmRL35AZGTx0aDJ560/iAqnTl5GT5Le
         01PafDi17TOTjnwIxyvRnFW3+ekGoEdN7GVEwGjEzx+V0Dsiub9cHXzFaoXT+Y6ntZ4/
         T5BKeAhPYahZTDi2Zlj1+ISkCy5eLMCCpQ/aI9AuNSSuToZKpj4GcfLyF15rulUqo/Qw
         B4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755593543; x=1756198343;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=meQtzR+ieVhgx/Q0wpHo6dmNc1XxiFtcKpS1QRJVYsY=;
        b=xFk6CGft6OrvdfW70KeD6Ui9UP0rLOwVCVH/7iX+3fer5EGeY9cgHWJZncrezZZhF7
         sSV5FPOaRuTEf2/GnTeQvtjy5Hnq870gmbDcTHdMq2rJ/a8/Aq0ldmvONUinRIyFsXWj
         0PIgJ9y7/0r/gxpKPTa3+Si33H5eDRagU2TXPwqPrA34PkzMo7HvJNA//mLQq+puUedi
         9TdZ6JE8t3GKPiAWot+sHSn0AhBWnABIvZittjixmsTCRnd3HzLn1KVcK/d+nNINXBy8
         zu3t6EbNCMppHXrEiyyK1nXi1oNJOwh/1hViurEb2gSNlQVjZ0Gq9aIg9llP4XLK10Pj
         j5DQ==
X-Gm-Message-State: AOJu0Yy1KXZxbxDlNMVs7HNvhRqt7QAKjEiCkZC7XMLDgIzhVbZseD0r
	lTOWlw4/LTaiJ6Hw43Gf1bkzS7SXszNSyLYedJrOnTB7BwfnfZCdf4lCfPMJBcCqSxf7mi5wjts
	mgKVP
X-Gm-Gg: ASbGnctf1c1YHOjNj7gv7Gkp6ZEk2sekpcGqr7K9GhHQoQcUCtJDXyKm6gfIX8Jo7nF
	5sIVWdvJrVCq8iLcsJ10bzAXsJzc097L/s123RWZvVPbSeVuq8q/Njt7J/u1GF8q6EvfHlnjdr4
	0SX3l/o01SQxBkXGJV0JnHAL4kFyE1Le+pKd7nbcqw7KX1V72XIgQuA3R0GNplUmOcO5fZvYeSz
	WyyyxWvy5nejjXRgWKYToQ8jCXv1VAF1VRO/k983nr+2LTlbAHMku7PHzrLyKJU28DqnpwaK7aE
	FREmp4gd7vtF0Y8a+Ad+i/rhcXFJO5qTaaZyiMUBL3nCOtZkGcMP3Zva+iua4mOjXIJbPgsjsQ2
	XCpyjfliCk2tb0aLv9CVZLshUWa6n+aDlz269Ljfwys0=
X-Google-Smtp-Source: AGHT+IFQmWBscHVVwrE15tazLV/Kuc0AxFllAhNQxP2j27yxb6DzfL8xDG4uCJwXVDd8ZWnhFu/Brw==
X-Received: by 2002:a05:6000:2f88:b0:3b8:f356:a2a9 with SMTP id ffacd0b85a97d-3c0ed1f3112mr1146021f8f.46.1755593543547;
        Tue, 19 Aug 2025 01:52:23 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d5637acsm102385715ad.143.2025.08.19.01.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 01:52:23 -0700 (PDT)
Message-ID: <02be4b86-330e-4f93-ba79-8218d05659ba@suse.com>
Date: Tue, 19 Aug 2025 10:52:16 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: modprobe returns 0 upon -EEXIST from insmod
To: Phil Sutter <phil@nwl.cc>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-modules@vger.kernel.org, Yi Chen <yiche@redhat.com>
References: <aKEVQhJpRdiZSliu@orbyte.nwl.cc>
 <8a87656d-577a-4d0a-85b1-5fd17d0346fe@csgroup.eu>
 <aKLzsAX14ybEjHfJ@orbyte.nwl.cc>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <aKLzsAX14ybEjHfJ@orbyte.nwl.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/18/25 11:34 AM, Phil Sutter wrote:
> On Sun, Aug 17, 2025 at 05:54:27PM +0200, Christophe Leroy wrote:
>> Le 17/08/2025 à 01:33, Phil Sutter a écrit :
>>> [Vous ne recevez pas souvent de courriers de phil@nwl.cc. D?couvrez pourquoi ceci est important ? https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> Hi,
>>>
>>> I admittedly didn't fully analyze the cause, but on my system a call to:
>>>
>>> # insmod /lib/module/$(uname -r)/kernel/net/netfilter/nf_conntrack_ftp.ko
>>>
>>> fails with -EEXIST (due to a previous call to 'nfct add helper ftp inet
>>> tcp'). A call to:
>>>
>>> # modprobe nf_conntrack_ftp
>>>
>>> though returns 0 even though module loading fails. Is there a bug in
>>> modprobe error status handling?
>>>
>>
>> Read the man page : https://linux.die.net/man/8/modprobe
>>
>> In the man page I see:
>>
>>             Normally, modprobe will succeed (and do nothing) if told to 
>> insert a module which is already present or to remove a module which 
>> isn't present.
> 
> This is not a case of already inserted module, it is not loaded before
> the call to modprobe. It is the module_init callback
> nf_conntrack_ftp_init() which returns -EEXIST it received from
> nf_conntrack_helpers_register().
> 
> Can't user space distinguish the two causes of -EEXIST? Or in other
> words, is use of -EEXIST in module_init callbacks problematic?

Unfortunately, error return codes from (f)init_module cannot be reliably
depended upon. For instance, cpufreq drivers have similar behavior of
returning -EEXIST when another cpufreq driver is already registered.
Returning this code unexpectedly can then confuse kmod, as it interprets
-EEXIST to mean "the module is already loaded" [1].

I have thought about this problem before. We might fix the main
problematic occurrences, but we can't really audit all the code that
module init functions can invoke. I then wonder if it would make sense
for the module loader to warn about any -EEXIST returned by a module's
init function and translate it to -EBUSY.

Ensuring the reliability of the 0 and -EEXIST return codes from
(f)init_module should help user space.

[1] https://github.com/kmod-project/kmod/blob/695fd084a727cf76f51b129b67d5a4be1d6db32e/libkmod/libkmod-module.c#L1087

-- Petr
