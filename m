Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B16E24E00F
	for <linux-modules@vger.kernel.org>; Tue, 30 Sep 2025 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759238190; cv=none; b=tyJE9rJcW+VUD3nXaZEjlTU6mNIqhtXFQh+aqs1+yxGR61JVuF6VjVon0yhGTRL/C08mG2MysaAQdrfUZpMGAXf0B+2jD3kFnjiYLcup+Zy8h9o8KXCHzfGDhUGFRPRu1Sb5c1gNO0qOJhL3egMWYGSaM7xX3vU2xupaZQz2LXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759238190; c=relaxed/simple;
	bh=vACPcvX4LWehkNCn3avFNQCRel5Es4xLtJf1RFoWwxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VLcivRcbFHeOM9DMoKUwRJ9YoZrz5us8AWjLazJYpAf/nWYGz+Nb1Y3sxcf+PpmtyX1etxBCziV8M5JkA31JCMtrM8OIpioxUrkYPR2rxlSdSHeatoYY2OgSHrvJfbbg410Dc1KVd0iecwaP01NoejqYP71CEecrcibvAkqJa38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KocRPIlw; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KocRPIlw"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-3ee1221ceaaso4836317f8f.3
        for <linux-modules@vger.kernel.org>; Tue, 30 Sep 2025 06:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759238186; x=1759842986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gdligv9Yrmq7/rk+Qyvy0jU8vW9q2hQx81H/VG9HIsk=;
        b=KocRPIlw32P6U3ZSi8FlWHtZjlLQYLWQZxha/GFDnrwhR7DQjO2ko/u9pNBUVFPdwr
         hmA50rCe38YuqPbzMdXIAnYw1UKEDUZQ7BecZ+JM9qvrbOwIF5UyzEpoB61/eoyuAI/7
         r5wOC2lFXYTuu7QXc3tg1O783qwOGTJfWqJD7c54mCla87VEIngn/1ISu12GjTmOzMiP
         kLKfQ4H5/j1GOq1dRhVUfGyV7HkldA+cySr3oP/jCc3W5dgCLfYRufa2HpK86PUAmpoB
         rVXOCaUc0UymInblrwjt4iNid/WlHyKGqIVTxUlsyas/+oYfP+k5bzpGTJHg29WR4z4X
         mopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759238186; x=1759842986;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gdligv9Yrmq7/rk+Qyvy0jU8vW9q2hQx81H/VG9HIsk=;
        b=uDGqCMLubIfpEkbGLrofy1T6LTVnJ1aFJy2CrGK3TkxiAZjFQC7F8R7oT4OVVRwSbV
         QRRpMDtHlf3u5+IlzyGt1nRz4+/Kfc8LDf5hwE+g7orUrjm7zGfNk+w2+1FZyW3gh5f9
         Iczf1MAQFsCERpZSr6FSIyH4dgAQLlu+KiLqTNiCJtKLC2m+mifDvc/cnDNy1GiMXG3Q
         YJ9binyV5CcDpn+bVkkMSTX6UVqc1w8LQYZxziMRPpn8SPW9jp4fKgjywH73nH/nUd1Y
         4mdH+vn7L437fe4pXN2LIt1bIG+2Ja35hsT7nqKK6+uzDIUTObijYyDnzItFA/XJGZqR
         GKWA==
X-Forwarded-Encrypted: i=1; AJvYcCXfLuhC/H7wIoICz26XWo2JP8+2bz8fe2p/4Rea9U9thfrCBw3byEu5h7G/yVw6zlHAD4Ao5YiKLTPMsWTu@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4E6dNfn3IjhnOk1ctTuuDNa4ArHOGVja2+pFAmxsUadlD6+xf
	jfDco39aMO+VUYinZWkQWmHwZ5ubDdXMUwh5xpcNA8nrRY88qTJJ44At2nKoPlVKDXw=
X-Gm-Gg: ASbGncvsYuHQTU71H+eUwYsm3swegfS8i4AfuvTAx9vHZAgMj/T+HGf9IlAwIg4xpLO
	pVX0fvgHT4aRPa8gBjnE3xd67JNVKMoCJvL8RytGnrgd2+Gjs95Sv3dwB1QMo2SOJNOsmGx8W+5
	SO5jIULGIKCuiLilzBtTP6kYEhWZr2o24qAU8FfQmtygfQ+PiuDaeue+suMdtzUCSferOogUoZZ
	jAxLJ1Nlm0WvbzsBrWIlqiChET7nroegd/5AUh/du8Aw+dnrn8IAd9KDHXzFKYvMGKODKMW6lGt
	suZyM0fgzig0k/EU8U4SR9CsCOH3cIM2190EnF2KRV+wzVpnELfY8tmwR6XwCFZ95mYKdvOUYhF
	8ZRTQrij+RN+J2YfyHEa8gd+6JzWcox4au9wUgSliFRZqtpyNGKD46THgLP1O//qA6G0=
X-Google-Smtp-Source: AGHT+IF1ErbbbjhopZL6pCF+T2Bztzzvt3Govsbo7Ke9CGLKtmmw2H4ZbQVixK6pD842k6HiDc4iKg==
X-Received: by 2002:a05:6000:2507:b0:3ee:1118:df81 with SMTP id ffacd0b85a97d-40e4623732amr18897288f8f.13.1759238186177;
        Tue, 30 Sep 2025 06:16:26 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb2eesm23337471f8f.12.2025.09.30.06.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 06:16:25 -0700 (PDT)
Message-ID: <3fc3f7e8-3297-4586-91ca-41f07c8a9418@suse.com>
Date: Tue, 30 Sep 2025 15:16:25 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] module: enable force unloading of modules that have
 crashed during init
To: Julian LaGattuta <julian.lagattuta@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250918201109.24620-2-julian.lagattuta@gmail.com>
 <000808f3-10cf-46ad-94f9-95a142c08b59@suse.com>
 <CADuX1qJZ1V32d0U4hSOUOzte2KE-k-Hzop0zZd4=7Ap-kS3JzQ@mail.gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <CADuX1qJZ1V32d0U4hSOUOzte2KE-k-Hzop0zZd4=7Ap-kS3JzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/25/25 12:16 AM, Julian LaGattuta wrote:
>> Could you please explain the motivation for doing this in more detail?
>>
>> I think we shouldn't attempt to do anything clever with modules that
>> crashed during initialization. Such a module can already leave the
>> system in an unstable state and trying to recover can cause even more
>> problems. For instance, I don't see how it is safe to call the module's
>> exit function.
> 
> Thank you for your response Petr. The motivation comes from when I
> wanted to replace a crashed module with one which does not crash
> without having to reboot. I looked around and saw some other people
> complain about it on stackoverflow.

Hm, I'm still not sure I understand the use case. If it is about being
able to remove a crashed module when developing it, then I wouldn't
expect rebooting the machine to be much of an issue. If it is on the
other hand about removing it on a production machine, then I think
attempting this can leave the machine in a worse state and not something
we should encourage or support.

> 
> I thought that if a module crashed during init, it would be in a no
> better position compared to if it were forcefully removed.
> Therefore, there is no reason why this shouldn't be an option as it
> couldn't make the problem worse.

A module can be halfway through its initialization when it crashes. It
may have already registered with various parts of the kernel and
I believe that removing the module from under the kernel's control could
result in even more problems.

The current support for forcefully removing a module overrides the
kernel's tracking of module references. This option was originally
introduced by "[PATCH] Forced module unload" [1]. As far as I can see,
it was related to the module loader rework at that time in "[PATCH]
In-kernel Module Loader" [2]. This rework provided raceless
loading/unloading and marked several MOD_INC_USE_COUNT/MOD_DEC_USE_COUNT
interfaces as obsolete and unsafe. Since some modules still used the old
racy interfaces, it seems the forced removal option was added to make it
possible to remove such modules.

However, this issue should have been fixed a long time ago, so I wonder
if even the current CONFIG_MODULE_FORCE_UNLOAD support is useful.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux-fullhistory.git/commit/?id=d0f8c9a4c2c9d93463d157248c73028670e80a97
[2] https://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux-fullhistory.git/commit/?id=4c877b08daf4b463c144cbd2748ed1659931a0dd

-- 
Thanks,
Petr
