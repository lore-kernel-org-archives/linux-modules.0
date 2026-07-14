Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B2035BDDB
	for <linux-modules@vger.kernel.org>; Tue, 14 Jul 2026 11:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028838; cv=none; b=PdawBMtu6jNV36iwjlD1+IEkz7uuTjUgcpvt3Pj/bjCsK6tA/S7wuRylVe8KRj54PXm1g6+QKX+XABVP8PFQBvW56oqCsA7QT5y8jmlvN8zeSqULK+u1Oox7khzaJhcAwBq/+UNInL8SNpHHW1tLKlaz12UshhEpJjGbTMLSJBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028838; c=relaxed/simple;
	bh=kkRfGYr7evXiSgLOaBtSyZkMM2vAxT6MtKy1j/OI5yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IcAAea8TV5esm00650Ztgxj6RjXs2Haq8Ib53t5ZZ27ATZ4k1L1F5i6w9+603XeztLCZhZn1w+JqxMJJFxqkROKqK7DBsWEWpCfzoDZ20F92Ic+YGhYiSUqtd1H7QpRwzR+ugqcHtVqbAoUr6fKSc4kCeQPOLquVuMHaIvdCPxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UI5RKn69; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UI5RKn69"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493ae59eca6so4934395e9.1
        for <linux-modules@vger.kernel.org>; Tue, 14 Jul 2026 04:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784028835; x=1784633635; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V7QEmIDAdftGvf7AuLdQLq+M42NOg346d/39BJGjeh4=;
        b=UI5RKn695SnFfzKw7e5J3GcRMNQtpp/FpSYjoSNhF3J6gLafiEnI1NrwCuDdjlSoJ3
         PznfW/IUCe66uG/VHS5P+Vr8PdAsHH2nlxxvBf5R4QL+yyScnwrRy+XSqds7a1u4EwQz
         eAnwKyv4XESKqdDifOCDp7hkMRI4pmSmYlMTJ1Gp3QrRtA1rXbDQyhTDlB1RU5J3zvBd
         wlM4is28g5H4dH8Ct7CFJrphqtn+ZYNrcnsXGArHlZI5w7oGt39ezmod8ZuPb6dwLS+9
         V68fHy4QoNnCzHnmUMqDiBf3R+32HGjbH3XAT79n2gsEsuEF6jR8EF+XEj7HY1FgHsDY
         op4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784028835; x=1784633635;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V7QEmIDAdftGvf7AuLdQLq+M42NOg346d/39BJGjeh4=;
        b=iiyynHmKaG62ksJzf/pRinrmdCecM5woulWQSTKeDMhIsDyAz6SY2zELUhzbUriYeV
         W8KFh3ZNk5mFqUKM1V2GsN+ebEo1IIxXHPlu20Q45C/YMTVmgMy1S3rgG2yLrdMpQZie
         lNqqSoEUfZh2K5ZzXifRybUkJ5Iq/INaw23v3ISjiGKQtosx/DDdv9AtRc7O/8PTqPQj
         /z5SgV7XvvO5nizYywPtgCsTRQYcv12/jmztWNhUSl1G77MPv04zaqIGG1Gav3pNJvJ9
         pOnMY4kmqmFthVnpMaPNfBNNMDE/j+GMb2X7C11FdoqgI8F3ji8gIrKymYUfwSyUf6PG
         cwlg==
X-Forwarded-Encrypted: i=1; AHgh+RpcMGyyLUadzPJd5/hALgpy59dUiv6pk+z4Qzq2vlPPZi4mmpQARlN2uBulL2z4//LuCanpFzVbuP5cRUaE@vger.kernel.org
X-Gm-Message-State: AOJu0YyHunI6cNY9UVjTI4VMYBkjT1fgwTOHg4KExmGU1YqEngDTP9Ec
	2QJRJgkMvWCpWP46Y4Z7CQxnQAdlMtbX3JtI/y9kt6FwBqXMSOWraeFAlGOHfv8yMXU=
X-Gm-Gg: AfdE7cli3tntx3z4VDWUjEwMVi94mdhoJ63LoD8uHfVuQtKgwM+hpJWn0XERsb3nCjl
	n1cDmoRHs9Aw1NVZZrXJr9OHL7Yyv7+fibH8IIm2SEBR289Wmyg2bd2NuBWXQgH9/DNij7l3EWv
	vhOScF5QKDdkijuiVfVZBwIE9thXzZU6rcGq72PuxW23axCMJokUbIiZgkOv1Ib0wfIW0WiI18M
	/bzLBwU4o+a8KBJI2IrYsPJAkbsJoXU9V222/gNO2hqPT9UyCQodu0TL41ra1vCWHl/2zRVhLB9
	tRop7kEAOAfMgfCom0gUhL+mtFfqZHvIpJwD0ytZ0QdAh2ge8XlNciun/IAzIhIANbxwt8TH4Jm
	oyswtuc7uV2eO5CFz9lZ3N/PYuBF+dlW/cqcQs6RnIPzUlSr98enZiwgsvJZgnOBtyQYQF8Gr4m
	hexlQuZJe3HFt4LNFVsAMWtwCt1vanbo1bGA==
X-Received: by 2002:a05:600c:4ece:b0:493:a613:56b2 with SMTP id 5b1f17b1804b1-493f87d8573mr124226635e9.8.1784028835160;
        Tue, 14 Jul 2026 04:33:55 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49508731fcdsm60488595e9.4.2026.07.14.04.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 04:33:54 -0700 (PDT)
Message-ID: <a9029c20-c6ac-4d2c-9f41-b49a83ff5c22@suse.com>
Date: Tue, 14 Jul 2026 13:33:53 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: validate string table section types
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>, Markus Elfring
 <Markus.Elfring@web.de>, linux-modules@vger.kernel.org,
 Daniel Gomez <da.gomez@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, LKML
 <linux-kernel@vger.kernel.org>, Siddharth Nayyar <sidnayyar@google.com>
References: <20260708012107.1621513-1-tweek@google.com>
 <99301e32-b067-4d0a-a087-2c77b1fe0a90@web.de>
 <j46ht6nbnztkkkjbcxgx2aq5msszjsvxg7cwffxdrxciihbzen@p6q6k6hakgzy>
 <CA+zpnLexK1qbCxpwQdP76B+F0JqCFJL3rEWnp8xShbLbepvuXA@mail.gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <CA+zpnLexK1qbCxpwQdP76B+F0JqCFJL3rEWnp8xShbLbepvuXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/14/26 1:37 AM, Thiébaud Weksteen wrote:
> On Mon, Jul 13, 2026 at 10:14 PM Aaron Tomlin <atomlin@atomlin.com> wrote:
>>
>> On Fri, Jul 10, 2026 at 10:23:00AM +0200, Markus Elfring wrote:
>>> …
>>>> Validate that both string section headers are of type SHT_STRTAB before
>>>> caching them.
>>>
>>> How do you think about to add any tags (like “Fixes” and “Cc”) accordingly?
> 
> Thanks for the suggestion. I can't seem to find any relevant commit
> for Fixes. There are
> ec2a29593c83e ("module: harden ELF info handling") and potentially
> 3c5700aeabd87 ("module: Factor out elf_validity_cache_secstrings")
> Both of these commits already intended to harden the parsing. I don't
> think there is any regression here.

I agree.

> As for Cc:, I can't think of anyone who should be explicitly added. If
> you have any suggestions, please chime in.

I'll add 'Cc: stable@vger.kernel.org' when queuing the patch.

-- 
Thanks,
Petr
