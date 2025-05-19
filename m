Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D055224503F
	for <linux-modules@vger.kernel.org>; Mon, 19 May 2025 07:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747640593; cv=none; b=ohzxouXaoiph3/s68qYb6dz1nENsm6sAt8ISBv/H0S37tPPwlQgBNdLG6Ifg1se4W79hdFEPGeACTFbcHdw8Nyhz91s6MaHH9f1eNzsCMbc5z5mOSoLmrmbuzRKcDbCMpbIUuHS7vrGLWED4LUMq1q8reL8/LeyN6Rmx6kRFy5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747640593; c=relaxed/simple;
	bh=A250QY90PeuYamYmjT18fKp5if03NB7+sybjueB78kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LzyhJ01DVbe6tZNxmuq/sDTdI+ZzUGNvR2nVTlu9QYvAMtT5q9DYa/6IxygwZrbvFOT5Ku+AG31oKb1PZU3u6dlEfBf0fHdGt0GKIq31d+W+Z08AIQazXyMHChrMAlAy0hsj/vSzLCTHTSElBmnedkqImLNSnI0TzOnatKkg+pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iolUpZBv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iolUpZBv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747640590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ryRO6jJvPT8U9Oy9p1c4Gs2cBHWghAA3qdFeVegb7Cg=;
	b=iolUpZBvG8r4FrRVv9e0NqsaMy07A9kOqj9sJRCD18SE2Me99cjlpb7JEEa7+Mra318wg9
	l0OAVV+nyCkd2BfRzxJshaiVqNLdpCGfKc2c0bxVf96d2k0R6WkpublPG+eC1A9ZR+jV+y
	kT4F2S4xtwHSWN5b+2lseKw1AjD27jo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-q36hNfAJNzusCzWPHsLKTA-1; Mon, 19 May 2025 03:43:08 -0400
X-MC-Unique: q36hNfAJNzusCzWPHsLKTA-1
X-Mimecast-MFC-AGG-ID: q36hNfAJNzusCzWPHsLKTA_1747640587
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a3561206b3so1068884f8f.2
        for <linux-modules@vger.kernel.org>; Mon, 19 May 2025 00:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747640587; x=1748245387;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryRO6jJvPT8U9Oy9p1c4Gs2cBHWghAA3qdFeVegb7Cg=;
        b=X7GVpMIxZ0KTlS3ulepInhUbgagbhPO5i+4TQhJipj973e3xUOTq8e2zn7OANkOLSg
         7fzZgepvrHhh7L/9xRT6hTZdkV857gEwMipuB3PrnassWx7oMiEOr/lHaHMiy5KOcbt5
         XHdyhKSzM1OJgFqN63MFuOj+YDasTIsThIZsxQ0gTvwwK/KjWVj19SCzT4q3UMANNgCo
         Ja2ZdMcSo3jGqmi58IpXQbRyIKjVxpzceIEDyb7ankWoIKPtKZd38Bz54vPi2vNKx561
         zbZL82CGjVyEYU83zOoDqh6t3cXuD4bTSkBK2nxFpRe2fSZfITKxjEnYko2TL8fJppQ4
         VefQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCDnY2byx8f18JegKzSlxGzXMb4/x5hd7p9jgichnF+YxdUx7acRafLABV+SmBqTFBDN1SpYU+FNC2tglf@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr+pP97lMuT7EtjNf/NdRTSSA9ZVY0wP6ZSaxCXVPI7GI8F9VP
	RtoB3BEQ5QMvD7FBnoZhvVEpgFI36nRqQeauhVmf6ixwNrNLp3/ccT75A7x6pqxxf8E/wllg8yC
	kez4AiQLXqTb2mIiwkFvFyM5C+IrhcffZCwEzLro/6q7iTHqd/lXRoOA8dTK/kVy8HKk=
X-Gm-Gg: ASbGncsieOyTpvgxdfNr7z6Q5kMbG4LO/KaaConssoejssVsRXquOSoxc2oq6A+Lse8
	DJA6Eh5/beR2ufZg6LHzFHBqieIsGbonEkx1LYkrDnAiMdHk0a9xMfzTZaRfGKKttRdPJgDqUkk
	FxNQTvWQNZcryMey1bKLtdAG4H47juzKrjtvpVmbYLkZ65bdAuVO/ALYU3VKf516wJIVy9Z0i43
	6pmTpNiOF258H1fMouhtcbrnoNtTKxFxu6w+d/7WZ0XJoMyeMbxxdyDeMKIUyU3nPTnVV6amxim
	p5a0qs9B4veC1TaZqnsM3fc8EXicem0vDY2YCnEu
X-Received: by 2002:a05:6000:2012:b0:3a0:85b5:463b with SMTP id ffacd0b85a97d-3a35c857114mr11370381f8f.48.1747640587501;
        Mon, 19 May 2025 00:43:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEo5t2FfN8bLjI/wDbPrK2IWkSKYFCA7Dg1FH9qKaY204N37vCmvrJJAAmiZgqkZ05cWPNN2Q==
X-Received: by 2002:a05:6000:2012:b0:3a0:85b5:463b with SMTP id ffacd0b85a97d-3a35c857114mr11370367f8f.48.1747640587169;
        Mon, 19 May 2025 00:43:07 -0700 (PDT)
Received: from [192.168.3.141] (p57a1a707.dip0.t-ipconnect.de. [87.161.167.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca8894csm11768115f8f.76.2025.05.19.00.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 00:43:06 -0700 (PDT)
Message-ID: <95f07257-1ca6-4104-8389-fa8ce97bd239@redhat.com>
Date: Mon, 19 May 2025 09:43:05 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question: a module for wiping userspace RAM before
 shutdown/reboot/halt
To: Danill Klimuk <daniil.klimuk@3mdeb.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 linux-modules@vger.kernel.org, "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <bfe72929-ba4c-4732-9f80-25cc7b95a0c8@3mdeb.com>
 <e55bd90e-8bbf-4eb2-95e2-cc636725a0ae@csgroup.eu>
 <e71bd62c-5ba7-4363-9af1-d9c9de394a54@3mdeb.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e71bd62c-5ba7-4363-9af1-d9c9de394a54@3mdeb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.05.25 09:26, Danill Klimuk wrote:
> Hi Christophe, thank you for the answer.
> 
>   > What do you mean by 'wiping', do you mean 'clearing' ?
> 
> Yes, by 'wiping' I mean 'clearing'.
> 
>   > Can you explain the reason this is needed?
> 
> Some of our clients want to clear user space RAM during
> shutdown/reboot/halt sequences of Linux kernel, so the process data or
> any other leftovers do not leak outside current Linux kernel session
> (that is to firmware, or the next boot software, etc.). The reason for
> it to be a module that will execute in a specific moment of the
> sequences is to make it more predictable.
> 
> I thought that if the clients want to use it, maybe it will be useful
> for others too :).

We do have the init_on_free=1 boot option, whereby any pages freed back 
to the page allocator will get immediately zeroed.

This also makes sure that if you quit a process and then 
shutdown/reboot, that the page content was already cleared. (otherwise, 
it would simply be free memory in the allocator and no longer "userspace 
RAM")

-- 
Cheers,

David / dhildenb

