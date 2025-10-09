Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A292C21E7
	for <linux-modules@vger.kernel.org>; Thu,  9 Oct 2025 13:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760017667; cv=none; b=LUVTShP+Ri7sB4CZt5LdIpqpbnCOgzQNLj6EXyqcOQ827Ftm4S/wwx0KE8dHdQebSCXJGUvll6J1RuXU+WVHY+OZc6IzzlSp4an7xfzvkID4IEaRI8AyCKDtCN/UfaxQc1x2UQn+cQ6NTycGhMSjz6lZJSjKw9SAMsBE9rNqcR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760017667; c=relaxed/simple;
	bh=h2J3GsCMaTJdDQG4tnIq63ijqHEg6mrA+80r2lEqQ6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gxcnx5aD3EMpGGl79AY31oAciwNMjE0DxIFybVVIqchaMsf5gsfH2NETLA9LGnES8kbXP4W+raAG/zr8w27I/p5uf+wloxA9r5d3dqN7ppZM+/rHiSuMU+FdpBG+FEGHNm1TUhn5Odk6x8rr48nHU7w+CCCGeH02obFxZhbsp60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aVZBO8qu; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aVZBO8qu"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e48d6b95fso9186695e9.3
        for <linux-modules@vger.kernel.org>; Thu, 09 Oct 2025 06:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760017663; x=1760622463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HFX3oqOo4NMfDVXC6yFVS1qOXnDlzSdzEdWkRMg2+iU=;
        b=aVZBO8quHiSmZwozyxRz3R3cKxD1WhG2ZgnZ/P/T96yTayPD65LJxqClwm+qDnS37Z
         CbDlOfXMNsJ4T6ODMKDW+lQIbr/6/HvDmbX2SjYLFZnSjOGWp20dXPjUvT2XsOq6QHPS
         Es4M24VmfW5e9AAgxe6lHj9BDpEg0jbkKiJsdnmInK1hWDq5KV7PHoErzrKt8MXpnlJk
         d2odYJ9SHnZ8lviHlhJS0lLcd/pA0HtQCYgIr+L0t5so1tBFbbOUXblX51nHVEBmMaFf
         /EXmA3aygqD5Pm5ujohZWgHP+WW0v745LCxPI40bPIl6C2w+l41Yo9Lf7LR311jXxQjF
         dz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760017663; x=1760622463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HFX3oqOo4NMfDVXC6yFVS1qOXnDlzSdzEdWkRMg2+iU=;
        b=tQFsCn0ns9vzV9zWk9yawKK0W7qA2hCB6xeUSoMr5NgAs16G8ITOSMlY9fNp/Xc4Ra
         vQ7lWfvRB8xVLaf4eTGVc2KtruQLR65nXsQ+VMKcjWHYXEscs/+Sdn3h1JNPI+hNpm3L
         qxbt2MCButXleTAyhwyxRg8h/pslIVIUDDhkOouFGIHKN+PJm8dY07eobbKR6F9Vi24z
         OvAfVeVrMrx1kw8EwRSursOxeIln1hopy6qSRU0FEh++PhqsysxJ0QVGono8s6rmaX3Y
         E2uYBWErCoWg8GCci402MEVWY9fJ88ROEKYIx9VdAvVwI8N3yd3uerGL6HahEyIqlOv7
         N1Ig==
X-Forwarded-Encrypted: i=1; AJvYcCX9krUnmuAtdIsJFU/7J6Yy/5EB9dj5cz8SMN5+iyB5oGVMtw8GFVOjGzprD6DRFuS7iGo+8DrmueEQKSoX@vger.kernel.org
X-Gm-Message-State: AOJu0YwqvQUGKCJB1z5imihq3MYm6i4E6IatASZlb8iRNQ5wlwI34gXS
	4SjoMv9UE73chP+cAkIAW18Ga3yI0M/yHi+5x42EYrK4okFxxfJOZMK2jMfGm7ocoPcGpg24Vjk
	ld5gt
X-Gm-Gg: ASbGncumscyOw0nJPpGRvX0NZqH6J1HC/Q/3cxGwCbt4QLqnCKYmWYu/bDnkO71BqWX
	C0X8t3rMxngEaHM7wwGugWvczl3D5gk5zTSoKIIjJrGE7lxkt7SdNzVh/MCx7lc/WqXUi9IFohm
	aYIr4z0Te6M5VCBaYZvZ8O5b4zHS1kY/mkueFIS5LOy7oENarhzfKB5uem+/5/mwxqFuM7SEumS
	nnF66UyXL0XMBLMptISsViIAEeB6wJrxbPrBIjVguu31BsEanxZFufb3XyHUtALgFyPodNojkwS
	y3sBkq5RqU1wh+H2E78dTcjRAEs/nTYqZNlHzRiJqNo6Anu3RemReQ61kXBpWov6DLLCLzW3t34
	eusy8MgHYrG7PbtL9hvEHIatggAur5Rk08LMZIuw54pIOCVTr3WRDHnUzGYiA2wLD9AY=
X-Google-Smtp-Source: AGHT+IER+K7JKZfBT/MNyKHyekML71O7i2GBEEBr8UmW2KWudnufPrgxFDoYXHpXQosvzv2OPPz43A==
X-Received: by 2002:a05:600d:8221:b0:46f:aa02:98b1 with SMTP id 5b1f17b1804b1-46faa02ec6emr41913535e9.21.1760017662729;
        Thu, 09 Oct 2025 06:47:42 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f083asm35076502f8f.43.2025.10.09.06.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 06:47:42 -0700 (PDT)
Message-ID: <ce7f293c-d9f9-4137-bcad-8cc492d34773@suse.com>
Date: Thu, 9 Oct 2025 15:47:42 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: modprobe returns 0 upon -EEXIST from insmod
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Phil Sutter <phil@nwl.cc>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, linux-modules@vger.kernel.org,
 Yi Chen <yiche@redhat.com>
References: <aKEVQhJpRdiZSliu@orbyte.nwl.cc>
 <8a87656d-577a-4d0a-85b1-5fd17d0346fe@csgroup.eu>
 <aKLzsAX14ybEjHfJ@orbyte.nwl.cc>
 <02be4b86-330e-4f93-ba79-8218d05659ba@suse.com>
 <i4ayzta5zgltyubg6bfr4mwqhl6goyh73lyc7j7m3vngvpooi3@boorlngxpi52>
 <hupl3hqym5ru3fr27s3elg6vti4fjtphdwvvyxmuvekc2w5mna@kilmmcgobw6x>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <hupl3hqym5ru3fr27s3elg6vti4fjtphdwvvyxmuvekc2w5mna@kilmmcgobw6x>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/8/25 8:41 AM, Lucas De Marchi wrote:
> On Tue, Aug 19, 2025 at 09:17:50AM -0500, Lucas De Marchi wrote:
>> On Tue, Aug 19, 2025 at 10:52:16AM +0200, Petr Pavlu wrote:
>>> On 8/18/25 11:34 AM, Phil Sutter wrote:
>>>> On Sun, Aug 17, 2025 at 05:54:27PM +0200, Christophe Leroy wrote:
>>>>> Le 17/08/2025 à 01:33, Phil Sutter a écrit :
>>>>>> [Vous ne recevez pas souvent de courriers de phil@nwl.cc. D?couvrez pourquoi ceci est important ? https://aka.ms/LearnAboutSenderIdentification ]
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> I admittedly didn't fully analyze the cause, but on my system a call to:
>>>>>>
>>>>>> # insmod /lib/module/$(uname -r)/kernel/net/netfilter/nf_conntrack_ftp.ko
>>>>>>
>>>>>> fails with -EEXIST (due to a previous call to 'nfct add helper ftp inet
>>>>>> tcp'). A call to:
>>>>>>
>>>>>> # modprobe nf_conntrack_ftp
>>>>>>
>>>>>> though returns 0 even though module loading fails. Is there a bug in
>>>>>> modprobe error status handling?
>>>>>>
>>>>>
>>>>> Read the man page : https://linux.die.net/man/8/modprobe
>>>>>
>>>>> In the man page I see:
>>>>>
>>>>>            Normally, modprobe will succeed (and do nothing) if told to
>>>>> insert a module which is already present or to remove a module which
>>>>> isn't present.
>>>>
>>>> This is not a case of already inserted module, it is not loaded before
>>>> the call to modprobe. It is the module_init callback
>>>> nf_conntrack_ftp_init() which returns -EEXIST it received from
>>>> nf_conntrack_helpers_register().
>>
>> is this a real failure condition or something benign like "if it's
>> already registered, there's nothing to do"?
>>
>>>>
>>>> Can't user space distinguish the two causes of -EEXIST? Or in other
>>>> words, is use of -EEXIST in module_init callbacks problematic?
>>>
>>> Unfortunately, error return codes from (f)init_module cannot be reliably
>>> depended upon. For instance, cpufreq drivers have similar behavior of
>>> returning -EEXIST when another cpufreq driver is already registered.
>>> Returning this code unexpectedly can then confuse kmod, as it interprets
>>> -EEXIST to mean "the module is already loaded" [1].
>>
>> well, it's not that it can't be relied on. There's 1 exit code that is
>> treated specially, EEXISTS, because that error is used by the module
>> loading part, before the module_init call, to signify the module is
>> already loaded.
>>
>>>
>>> I have thought about this problem before. We might fix the main
>>> problematic occurrences, but we can't really audit all the code that
>>> module init functions can invoke. I then wonder if it would make sense
>>> for the module loader to warn about any -EEXIST returned by a module's
>>> init function and translate it to -EBUSY.
>>
>> If it's a failure condition then yes, -EBUSY looks appropriate.
> 
> something like this:
> 
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index c66b261849362..e5fb1a4ef3441 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3038,6 +3038,11 @@ static noinline int do_init_module(struct module *mod)
>      if (mod->init != NULL)
>          ret = do_one_initcall(mod->init);
>      if (ret < 0) {
> +        if (ret == -EEXIST) {
> +            pr_warn("%s: '%s'->init suspiciously returned %d: Overriding with %d\n",
> +                __func__, mod->name, -EEXIST, -EBUSY);
> +            ret = -EBUSY;
> +        }
>          goto fail_free_freeinit;
>      }
>      if (ret > 0) {

Yes, that's what I had in mind. Could you please send this as a proper
patch to the list?

I only think we should include a hint to explain why this is a problem
and simplify the message somewhat, something like:

pr_warn("%s: init suspiciously returned -EEXIST (reserved for loaded modules), overriding with -EBUSY\n", mod->name);

I realize you based the message on the later warning about the init
function returning a >0 value but I think we should rather update that
message as well. It should follow the usual style of
"<mod-name>: <error-description>". I suggest simplifying it to:

pr_warn("%s: init suspiciously returned %d, it should follow 0/-E convention\n", mod->name, ret);

-- 
Thanks,
Petr
