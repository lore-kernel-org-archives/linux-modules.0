Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357F521B9E0
	for <linux-modules@vger.kernel.org>; Wed, 14 May 2025 08:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747211677; cv=none; b=NK93TC6HMIcT8UNg5ki4L5kbCk7Nzd/+PLL7FumD2rDmF18VzS6HgWfxzlRZreB7zcZL/wq0C7phw39xyDBeEow1tT2v5Pgfa4jCTkzBQbpON1Bc6XR/Kbn65BQ33o4asqeEywOLbdRxckCHSu+h5mH+emsHGyoLCC89fusDo2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747211677; c=relaxed/simple;
	bh=413HM5eboYj1vCQAGypKKKAbvRddV4u80mvB/tL2F9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OzGM9JmtxPi2DU2knJzVRmt5zIrbNdOhU8Nlwg38vrdfc49wM997BXDgwaxBRsg0erPwS7rQ40f6nrK7xCWU3g7WO5rbyZ0iNT1RUPLiOgpibaPFmZsjW/cr09LuvBxCnUIbdQp5EZVhT3x0YF/9lMza8NsUREq9QeUwRsivQ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SrUIcqaP; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SrUIcqaP"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-441d1ed82dbso69311505e9.0
        for <linux-modules@vger.kernel.org>; Wed, 14 May 2025 01:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747211673; x=1747816473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pmPxzvplp27sf0Mh5TNQ3UmGJf69Of2vzLV4ej7YVkA=;
        b=SrUIcqaPODojagnPoRW+EgNHSzbIpuBYPruB6ViPMGqoWp97FIvecSlIJ9uDylMavK
         c+Gv4QFDYTXd5PTeupnbsBREDXj15BaTcDV9YTCvz2N98yQFV3v6M6oqsFqpsPkIslFJ
         sIHjtvuuwsVzmNrfa9xXRCLBUL2k1YQ3EAl1bP0fBAgdEAVHsZ04GzYB0WHio/Gdv0PC
         eLErMCCqLjeyEI6VCzzS+rKWhX8k4Uydyd/aCZLbhk4js22y1x9+oUULlKNqaq4+/l/7
         4Xu2OMObHFjrvR4UEADeMmgGj0+2CoGpO5yUOvVIydLvWp8HmUq9LGZPHCiHNfI4Rs5X
         xrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747211673; x=1747816473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pmPxzvplp27sf0Mh5TNQ3UmGJf69Of2vzLV4ej7YVkA=;
        b=b9GWZM86urbvf82c/WBQMVmFljBQP97h7wYcPeMjp/eFkH9DtHnUSseb/ikYZYZFCS
         u1HxO9MpbJr6TYyVnVwcxB7JmcLn7BA7QYBbw5KDg1DKuBEKcVmTrV+4Vzg/Ka4f4dOF
         Hadlg7ENx8Alqj+ibKTrOaXbeaWgRr2JOOP4QEriwv9ecQIP49PTNKsZDw/2btpz26fj
         XvHr2CzgSSZgifW/BbLC5hyZ0T1oVmbq0as8icl8kD18VEBftDNileq8u/0EZcmXCuN4
         Mpxfws0KHE/bVSOhiQ5/1lCIEKt5Q5vXlnJcw9wDHB2KyDwWpE5DgrAmwb8Cu9bTGzZN
         QPmw==
X-Forwarded-Encrypted: i=1; AJvYcCW2+UzBqagI1OdBsRymHEN3p0xa8+0V9VXfE7utH0MEazK0i1UkEWPYoww1lrUzNlrHooi/zO9Hy5COrcJJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yynhs4RoNcUTRBhc3XaVKBW0MWYydAs2UQdXTlIlJ+sKjDtQBYB
	eN7YWtbp8d9jb3FdrqLH1s1hFlroCiDkE/yLXovKT4x9i7JSTXEBWDAFwV4Bh8w=
X-Gm-Gg: ASbGncubX4UdogI8BTf52UIcNQ5EUtcJM3POv2UveDZXj5GhX6J0u0WDVkW6q8OaOsp
	EWgBhLbBSuI4avjbIXdwW7QvI4N80EbTuHgOedY/NrFvMLW7cCqWpK/dkA476YNZlwaVjGTcXPc
	qxLNcuIZOlMkPLSJvajFA7QExJaL71zxu3cgbYO3fP2BEAn7YDyjbw3wIeQ/2LLNCHCvUXaF2nt
	468E9FL+P4F81z6pA+t2kXRcGec4jRYhIZl+31EPcaJlWbRcpSIek9yd+qDT9w+jDZSpQFtp+EV
	EDa0Yzqmz5i00hDhk4b/DajCqO7IchviC0b8phIRTHPvvto+ZD1asA==
X-Google-Smtp-Source: AGHT+IGMrizPwMYXPEGeYJfqWtlgiQDVjgsMQKbEsCq+MVhFWOKzPY77w7J6frRmGyePbOUN4M6Vhw==
X-Received: by 2002:a05:6000:2dc4:b0:3a0:bb2b:14e3 with SMTP id ffacd0b85a97d-3a3496e7095mr1945171f8f.33.1747211673499;
        Wed, 14 May 2025 01:34:33 -0700 (PDT)
Received: from [10.100.51.48] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-879f6297d9esm8160828241.28.2025.05.14.01.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 01:34:33 -0700 (PDT)
Message-ID: <81444b38-e0af-4278-89ad-e25cfe08179d@suse.com>
Date: Wed, 14 May 2025 10:34:24 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] module: Add module specific symbol namespace
 support
To: Peter Zijlstra <peterz@infradead.org>
Cc: mcgrof@kernel.org, x86@kernel.org, hpa@zytor.com,
 samitolvanen@google.com, da.gomez@samsung.com, masahiroy@kernel.org,
 nathan@kernel.org, nicolas@fjasle.eu, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org,
 hch@infradead.org, gregkh@linuxfoundation.org, roypat@amazon.co.uk
References: <20250502141204.500293812@infradead.org>
 <20250502141844.046738270@infradead.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250502141844.046738270@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/2/25 16:12, Peter Zijlstra wrote:
> Designate the "module:${modname}" symbol namespace to mean: 'only
> export to the named module'.
> 
> Notably, explicit imports of anything in the "module:" space is
> forbidden.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Sorry, I thought this was already reviewed from the modules perspective,
but I'll make it explicit.

Looks ok to me, besides the already mentioned "strsmp" typo. I can fix
it when picking up the series.

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
