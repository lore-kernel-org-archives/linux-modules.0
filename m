Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9586D2EA721
	for <linux-modules@vger.kernel.org>; Fri, 19 Sep 2025 08:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758269889; cv=none; b=YL5wvjh05r7s0JcUGG7LwniSh6YraXrtvwm6W1sjx6LbnnAjdwry5wSrBOBRGoCsEcrUVFLMevOnR4jufIIHBxZZ04tRYbuA43sAKqmFLFhucQYKUxOlwt0hrw2coEVw1z+wCol3e+lN205F+PEFs+1nWpX3/0MxJmUezcU8TA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758269889; c=relaxed/simple;
	bh=DyMqZzpbMkJgkEnGSTyBtxfZ+e/F+bKP3TSdsbcQBe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=czbkcDpPX96thDfazwlUMhVdPK4ADj7n9iHtP36Cu6lcmwsRS7L39gddsJQNY0w0SQjjlXza44kzLQnPLzq5gXpzpbJu2rACDLV7UnsbvdGR0oanVByF5bFeKocVhaJshihZErbLZOoE/FvjHQSkdN0E8riIzUc4t8qq7yDL3F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cMibZPm2; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cMibZPm2"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45f29e5e89bso20071045e9.2
        for <linux-modules@vger.kernel.org>; Fri, 19 Sep 2025 01:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758269886; x=1758874686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5o43K7Y0uvDLyzASUv52fl9L82q3PGfkNuSA+w+tp4k=;
        b=cMibZPm2CrHmhNmC3Rwd+2SdeLKp2fBzLJ1RSvd58XZ6JDdxbtd7Jl4ijVrFvRHROM
         wfS0R5BDcJ5bFaAJLSVr+EPUkDSagLgiaxzolMicHN7dP9Z+9TyKCcmkXg9v6dEOLHZP
         udD0+BSMZW7MFUQz1m/VsQjCn4hdlmHh7XOIbLraWXlUNWYZxq0VXb13S1TSjUJjCXyQ
         ZvZfnpwiym2tlPY2JKUbYcfG52uKGk+cOUVnkwfFjhDc/g7CZnc0jQu361m3eXBfHi/H
         +HTNZcjyBFivxCMNFnraon2nMzXueQrNeKS4Dv3wG22MRh282K3U+4Rsvt8dEe4qszDJ
         CpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758269886; x=1758874686;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5o43K7Y0uvDLyzASUv52fl9L82q3PGfkNuSA+w+tp4k=;
        b=MDbQMoA6y539Prnu/tMnbexE3fNUb8eDZVX8sK1bwVy2FsGgykC1GKUO5Lo7pcxC4Y
         pd/y/7iD259m64/Ak/5Kgtgbqyxc1wHPyp20461RviCTHkK+eO4ezr3kI/iq6dY0O1Ce
         Oz8UXxgMzU0rodrEk5C36yKSgSElY/HXDVhpm6RD6Y3GvGyc9RcTt6J6bHsorLP1TEvp
         OY36TTL8w+Fp7xqKVBW+3VIzYluOYBO7JukYa2YYWJmvEblnWvQArTNmF+os/kp8OVs2
         9lk4y/cdGJDfqzWS4WKSGb1T3cuNwhdkdtmr3H0kUo2m0bUGZL+rxIaNsXxS3lgrRc1c
         Rhrg==
X-Forwarded-Encrypted: i=1; AJvYcCVj43uUPJG8TThV1CwzoBQqVzpVbxS4bkg5/YHVm8Wew1ScVWRNE2JecOSqRjuUyApTyuuylDtb2T2bzC7r@vger.kernel.org
X-Gm-Message-State: AOJu0YzfYjF1h0O0YGOiyPl5Z8uFpRQMeSPZGYJeXdeeiv1obIwvSQRK
	C0tPCeDcuz143CTWTyz/se7T6Te2rpw3JuSbFMJ+P3Z4gxaAqQp0Y0NJC58OKNRQQew=
X-Gm-Gg: ASbGncsHrw4gzyUuMdlwg6aMDzZrqcuN8xO8KB1LWBJeJ/CvdjTlggi/L/LVr+Yn56V
	um5tSOtw9VsC/qiFSq6tCGG55ESjdwQVLOFzkLciX8M054LVJWGn3wdkqEddUECoQQbmVe8ULDX
	buHKz+nfXku6JhDlULuL3wWVW99G5Va4psNNXRnFKowsYIbEalqygP/zvlE3FtH7fkQCh/g9SlP
	qzOoX+VpPS3fsi1iXOAorRVIGCmK0C5+LHvsHRLyh7NOQzekS+tQiFa5/4suUlt9uXYJHaSBPVF
	f5wTSotLpDmeyGcKxd6ABGa/VjMXv5aOJCgDksSR6JNnlmQYAymOwP+0F3apdEQUCANlB1eBQju
	qqRDsAmt6ZpXxK55H+8m6lOwfZd179+buI50YK6YU0dw=
X-Google-Smtp-Source: AGHT+IG9IXvO0ORWH5ghDWSBVfrFKgK8sq0GS7GYB45OO3lu5+7LJG+GncUqXyvk6ZUL/55POHIftg==
X-Received: by 2002:a05:600c:1c05:b0:459:e025:8c40 with SMTP id 5b1f17b1804b1-4684c13ec71mr17359215e9.10.1758269885811;
        Fri, 19 Sep 2025 01:18:05 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f4f9f4e4sm85674225e9.13.2025.09.19.01.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 01:18:05 -0700 (PDT)
Message-ID: <679c0f5a-bf19-45c6-b28f-b89fe9c44e66@suse.com>
Date: Fri, 19 Sep 2025 10:18:04 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] module: replace use of system_wq with
 system_dfl_wq
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
References: <20250918085525.122429-1-marco.crivellari@suse.com>
 <20250918085525.122429-2-marco.crivellari@suse.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250918085525.122429-2-marco.crivellari@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 10:55 AM, Marco Crivellari wrote:
> Currently if a user enqueue a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> 
> This lack of consistentcy cannot be addressed without refactoring the API.
> 
> This specific patch replace system_wq with system_dfl_wq, the new unbound
> workqueue, because the users does not benefit from a per-cpu wq.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
