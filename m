Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A3C3E92A9
	for <linux-modules@vger.kernel.org>; Tue,  5 May 2026 08:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777968364; cv=none; b=CRf3w86FZv6AU8iCXKQI569nirqYPW2Jf1N5TJ25NHXuVAjWiwoctTkFbItGwo4m12Uifr5R7lvn7rbO7IV7+SyEmTITWkV4nwaBGJYr6YDKV1YCwKG7U5xLiaPTRM0rpefEriNEsgz+Uyz0mG5CKtNKuUZL1DEgPg6/2J5MZRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777968364; c=relaxed/simple;
	bh=TqmMZNCY2zf4QpwqPM5YA+Bf0rrc0JuU37dmVTHaVow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rTwm7peRfrdv8HvdmUxSEC7ZjkCVns2nia7mIvI7Zdh0CNR4Ma6RMlb8z4CXGaTRitWxA+OEzzsKp/34jcSH2ZcGDiGH4YxeSTq2zR95fMV2k1Ab5lzAAFYLVoGXcqaIrv1IDEb1dUpp3LqiK/CJ7tX7bSjZfQBVTe116rg90QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ESh91f/S; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ESh91f/S"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891f625344so52702905e9.0
        for <linux-modules@vger.kernel.org>; Tue, 05 May 2026 01:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777968360; x=1778573160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AYTfJuO6eDvzZyUqAfwF5shhmAD0fGlXoIMF7YvMKg4=;
        b=ESh91f/SFF/5/3/7Yh6ouulvWK8LuLWqVtvZLJRUtVKYSvbDr+AiD/OFI6OhcuUTvj
         1YJFhEJtQN9EHRxXFL+xYrCmnie5w9XxkjL2c583rBu8IwoUcG/6+1/fHH7AlMP+EsyK
         0Xy4l3b/4KyaJhr8KCALjbL6eNCLUxXhZEHE5vvGocOrd2IdRyYOe5a4MMJr+ZRWKuCZ
         2X1kMiCUZmHVq9WILoMUegVtbioAGelhrg5fvBYfSKoTAhlsuvDjWHwidUpkeAanOLOh
         8YcK3vWaD1l0R+Z2Onk8cJ+qDtVqiWA55hgmfOG12GKeCc2w2sQEz6WilgFWljsL6ltK
         X07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777968360; x=1778573160;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AYTfJuO6eDvzZyUqAfwF5shhmAD0fGlXoIMF7YvMKg4=;
        b=eprxhaoUkyCKBPPQ2Bn8sQhcpn/hG4tzYZ71f98ltgr5r8NxzRTCIl6/U4DwCB/2TB
         8gwMSCol7iNjafwPGs50jGkxgQJ4g5DV6xt0o5VGTbUUhCARW0AzMyyj90NM9iMKYOYQ
         UJc1d8Jh6BkWBzN1XD5xzuGZo1+Bvpio4PUY4uv+nv65CeRvhnXuBFeWfgVGjXABDuCx
         LEhE17856SvIeZ+qDCJzbDNiBDHJipnOqIopoEqJ3YKgGb0sJwazTGzcqVrOmHMxoUhr
         aoNgFlQJsP61C2cJTJ2xq6QsLvZWUhZzwE0LKF24MRm7gpORC8chkjmY1b5t4jenMDmL
         lyRQ==
X-Forwarded-Encrypted: i=1; AFNElJ/GJNVR9e66j4bfpgG2eRpyBUr2+fPW/7mgG9EhzpqdFbBNU8mYuFU7STlN3W64Z5+tIaCeHLTdu/M5B5WU@vger.kernel.org
X-Gm-Message-State: AOJu0YxiNAqpQ/QzXWPHmNCkKHYzp0fxkOuxPWzzkQWWbyWHLHiKaByF
	SOldmXnNiVtE86N285Y8MoMGLX+so2G3IcuvMSNJRs60/86/dzYAYvwcJP4XkGjq+qA=
X-Gm-Gg: AeBDietuXcNrLcfmbwGk88t/K0fv87p9IrldqzqjTy3mYCu+LBg3xq5otoNSaRiDE92
	gEbHsnfB3+CMqWmfa+j4oGBiBaKQ4tbIerLXGkqgNrEn6JQBj1LyNiZajJ3Ju12BAvfz1ddDUJB
	LMxtmEIIAh0h2A36MDrZL4eZ7weEnnMdMJ0HAh8iCHj2XSeVlsbTpqpN9NFyP8dl3LsWxG3WOju
	IbaQXlv+esVXHyrKJytGZDrcVDzYe5Kcu0D9CfObUHWkJmJIATuvyn7Z1yKzbiVa2y0P3zivm6e
	iH+/ZRy0Au2S93NMTUNNfc++VxllQ7gULnTZc8N/YbHQkj3SWtCuTjRW8cUSvz6cpXoFE0+T2WH
	ivvM9ogKEk7OcuSV860NQcdLCAPB4PkBnTMcnavJegjw5nXVm9rpn1w99u1ufsr1Mi0ylSST3uf
	NM+M9KAfOtPAO9T1Ehz9NIh/A8wwGpEn5t/FA0X6ws9QlqnFMoAE5XvbzqYeMm53DvSw==
X-Received: by 2002:a05:600c:528f:b0:48a:79d8:a8d6 with SMTP id 5b1f17b1804b1-48d14243e52mr41638215e9.7.1777968359879;
        Tue, 05 May 2026 01:05:59 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82301b7bsm453727615e9.11.2026.05.05.01.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 01:05:59 -0700 (PDT)
Message-ID: <3b17d3a1-bd84-431d-86a8-bf5dfcac09fc@suse.com>
Date: Tue, 5 May 2026 10:05:58 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] dyndbg,module: make proper substructs in
 _ddebug_info
To: Jim Cromie <jim.cromie@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jason Baron
 <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Shuah Khan <shuah@kernel.org>,
 Louis Chauvet <louis.chauvet@bootlin.com>, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260504-dd-cleanups-2-v1-0-6fdd24040642@gmail.com>
 <20260504-dd-cleanups-2-v1-12-6fdd24040642@gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260504-dd-cleanups-2-v1-12-6fdd24040642@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/4/26 10:45 PM, Jim Cromie wrote:
> recompose struct _ddebug_info, inserting proper sub-structs.
> 
> The struct _ddebug_info has 2 pairs of _vec, num_##_vec fields, for
> descs and classes respectively.  for_subvec() makes walking these
> vectors less cumbersome, now lets move those field pairs into their
> own "vec" structs: _ddebug_descs & _ddebug_class_maps, and re-compose
> struct _ddebug_info to contain them cleanly.  This also lets us get
> rid of for_subvec()'s num_##_vec paste-up.
> 
> Also recompose struct ddebug_table to contain a _ddebug_info.  This
> reinforces its use as a cursor into relevant data for a builtin
> module, and access to the full _ddebug state for modules.
> 
> NOTES:
> 
> Fixup names: Normalize all struct names to "struct _ddebug_*"
> eliminating the minor/stupid variations created in classmaps-v1.
> 
> Invariant: These vectors ref a contiguous subrange of __section memory
> in builtin/DATA or in loadable modules via mod->dyndbg_info; with
> guaranteed life-time for us.
> 
> struct module contains a _ddebug_info field and module/main.c sets it
> up, so that gets adjusted rather obviously.
> 
> Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

Acked-by: Petr Pavlu <petr.pavlu@suse.com> # module
