Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A7428CF48
	for <linux-modules@vger.kernel.org>; Wed,  7 May 2025 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746642037; cv=none; b=buypY0jjWAi2R2n5z9QqgMf8LmrcBIMqbL6L5uX3XKh4FujiI1Q5O8riP4/wCdcdkBmVGlj4yPiddktkBUpq1vlc+WvaZdhjsS+wm1+ICsFjoa229Nc877zf/IiKwmvaTFpIk760ndR50lQuQnA52GB7qXvkLLTdTnlGoniJc/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746642037; c=relaxed/simple;
	bh=z18XYgcChS8zXxNh9QVEEmab39x+LJVWC0Ype+RFzD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sEr/wrQLIPA0xsjFjhXfxhxlWrE7c4IO6wrHlu3p2FjBHvmTtrutdR2fKwO2mjRyQwDkW7iUq+h94RmSAyh9yUai+uuuFl4/0hJnD5mH1nrxMD5O1j0CGXAvvWEeY/wyfTCXtRF5/Ok+1KMmVrHeoVMd10jqnbjg18IRQ8bRgwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WVJ/+A5U; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WVJ/+A5U"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5fbee929e56so258998a12.0
        for <linux-modules@vger.kernel.org>; Wed, 07 May 2025 11:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746642033; x=1747246833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6KmTwub5XIvzQEqAnm2rWJBVIWH4S6tV1qp7ip13xz4=;
        b=WVJ/+A5UK0SgmRwV+bkUGkU/GOChgCtrEE4KcIHQ0YesFc/SEpeyR8N/m1G6CZVpd6
         /ZrR10gc6lMxjlQlkV8XQwGPL8ypU4Wh3gId8YUkT9h/b5aNzqzgxeI7p8tVBOKTKXsf
         6KU62Ai5Qy2IYO2BSM4fdcmn18Lm4/KBgneJlx1301MTm+a3/8HGTinTfLMCZRqbFT0r
         7aO1PzOhi5U0vUbKlRE1v43RbrQpkZsacrYomjgIaqiRxLL0USq9GhRDtVQzGgsyBml5
         6s+0MdJgdgC1QpPzsFlIltqx3/E7b8St1N2NMvRVQldgu2KCIAWtImPBLWaGkGQu4hJp
         inQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746642033; x=1747246833;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6KmTwub5XIvzQEqAnm2rWJBVIWH4S6tV1qp7ip13xz4=;
        b=GctxXBJ25LSV1nZkvW2aIchBhkXwJLZYsU4vTBUSFB9YFM4R+s1i4BUPt9ByGWTZR5
         /FiXLtPCL9to9j4jnBHDNIpamgKNY/VgzL3n05HjThvGbsOikfWSzRs+zzgf0PFZH9N/
         WmtgiRvJH32NqdXHtbiX7RzgLcTfQ0G6bXdLUdQ7Y/3a90An36BT3OZUdCQk6n1S415N
         xJcpR0VY5A0Jf0zsSLTmRcep/7m7ehmWSUwPUFQxZbHe4FgnqA+EU27CHsr3duzuS5Zk
         Tv78O3AD8HGKREoWLYQIeoWahA8ECKUzLW3RqPU41XrVX3Pywc5ZB51BOKaxWWPndF+L
         MwDA==
X-Forwarded-Encrypted: i=1; AJvYcCUZaawVIdnANq/bIP+EqDjU1jFsgToiQrUeMKOVn8/SmApns97o4ZlWvMU8bkxx3x8pL4KltdbEiBcuNLgC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4p3PjxS2davKrf6AzJl1GwlyYU6Dwq26pRkcNW/vWeiOrU4JE
	XKN0Z8/3lC/PhTSLwQEWmXfPt0mnfUK6XYAZCIq2DL1Lt2SSicF6azxaUUf4J1w=
X-Gm-Gg: ASbGnctmj0BB1zKaMrEs4qIzmFEe9TA6braHVf5uLGfWqY3hj2KBRGL6my7DP3hguFN
	Ca6nl28ednZycKz1yfBPboUOi/DCj/mEHlOpUjMvsQiqCj1nrRRX5zYH9BKFWrFHoI8kv2hXTuZ
	8X0eZkEAsY4E+0HkytDzpCYqSjapSuQWTfXm72t2axDGYUkQWK2SvTL9oCcEgrOMH6zLPQiduOo
	5XFY+CQPERwE+mL63s2MEKu4XDiEaCZcc/pbUR/fNGe+fyPyutxeQ/Um+qrqQ0DZ/7AB5MJshYg
	Jyf8Lh6r6WOMmtWjMFJm8phFDSHWRNnR0QRzptlmFnQ=
X-Google-Smtp-Source: AGHT+IFhovQZrxUkJO1Cd/g09v88kM+KY2DagbzTEVR+sEJpE2K8UB9dnM4lHSRFg9sLxb7lehAbLQ==
X-Received: by 2002:a17:906:ba86:b0:ad1:825f:e326 with SMTP id a640c23a62f3a-ad1e8e2b533mr365610566b.52.1746642033065;
        Wed, 07 May 2025 11:20:33 -0700 (PDT)
Received: from [10.100.51.48] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad189508dd9sm947958766b.144.2025.05.07.11.20.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 11:20:32 -0700 (PDT)
Message-ID: <a5543fda-6dbf-461a-9bcb-5750a459e140@suse.com>
Date: Wed, 7 May 2025 20:20:31 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: ensure that kobject_put() is safe for module type
 kobjects
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Shyam Saini <shyamsaini@linux.microsoft.com>,
 linux-modules@vger.kernel.org,
 syzbot+7fb8a372e1f6add936dd@syzkaller.appspotmail.com
References: <443b9765-3677-4bff-a6b6-a89f6c73cb67@suse.com>
 <20250507065044.86529-1-dmantipov@yandex.ru>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250507065044.86529-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/25 08:50, Dmitry Antipov wrote:
> In 'lookup_or_create_module_kobject()', an internal kobject is created
> using 'module_ktype'. So call to 'kobject_put()' on error handling
> path causes an attempt to use an uninitialized completion pointer in
> 'module_kobject_release()'. In this scenario, we just want to release
> kobject without an extra synchronization required for a regular module
> unloading process, so adding an extra check whether 'complete()' is
> actually required makes 'kobject_put()' safe.
> 
> Reported-by: syzbot+7fb8a372e1f6add936dd@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=7fb8a372e1f6add936dd
> Fixes: 942e443127e9 ("module: Fix mod->mkobj.kobj potentially freed too early")
> Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Added on modules-fixes.

I plan to send the fix to Linus on Friday. While the underlying problem
was already there, commit f95bbfe18512 ("drivers: base: handle
module_kobject creation"), merged in v6.15-rc5, made it more exposed and
I think it's better to have it fixed in this cycle. The patch itself is
also safe.

-- 
Thanks,
Petr
