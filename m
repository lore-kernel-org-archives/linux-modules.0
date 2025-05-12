Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EE41E503C
	for <linux-modules@vger.kernel.org>; Mon, 12 May 2025 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747061468; cv=none; b=iAaJrSdN9S3AZfeKvSJa/adIizJvIMsSCzFpcEJWO3jAgIl7caulxgd0cyrQdHrp6Ld1xSzXp4zewmzB31wCuri+yjD5IukyAtSElzGqPsE9bL6qKSB0uPcsM5HLr08+hxCNcjvz3TDWN7pXIaepV/HvT7kreyniZS4MSkeGmKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747061468; c=relaxed/simple;
	bh=D8ERM3wxNy4SIqS55lDq5eZ7zd9yV+0Q1RkUN1uIjB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kVJGfR849DtE+YeMwJJCqGNdlrbNp8x/9P7ooHbn9FLeshrYkY3vRTtp2nz4usYGSpLdcUCFjL07Fp/5Ng+aYVFEoUjKXcg+ELJUl/z9R4gHoJFKzO3YVvzZV1om5Cf4lVuV9P5bEnWlJnSxLowc5yExt0vrc/BpOjsFbSG5f1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R7BTSxSh; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R7BTSxSh"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5f3f04b5dbcso7313304a12.1
        for <linux-modules@vger.kernel.org>; Mon, 12 May 2025 07:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747061465; x=1747666265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lu0Ka+btw04+FB5hra+I3uxj0tOrSX2sD4d9HHszObc=;
        b=R7BTSxShnp1HCUpcRfNPaal36O0Gyi6CYe9RgmOIcW1R1ReGctNVyla2//Jf7hr8Ol
         V9EArf5W0YJvRXMyyCQuPj3JdIV4BNPrDjL2vCcnFNpTAq2kJlsvtkKwc7aMLmWCgX5Y
         Df588aGPLk3/j3gvDT8GfsIZW82eUzdd7P+OE/NdPLoaFXcDZjYq7Z1KwjP9sfueBr75
         iWXOMAleKBbX/aRTQ0u9W6tRtZKDgdW4t5l3hhqUkwkFsnVBo70rGYmP3D4dvkQApcGd
         M9Z2C+V2f4vJlIHafUTxLGHcBuUix9839MFzdZY1xCfL4oKVz/XfAqCkXCNP+aUeFCsX
         n5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747061465; x=1747666265;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lu0Ka+btw04+FB5hra+I3uxj0tOrSX2sD4d9HHszObc=;
        b=EWR8CLMTICY38n1VRTRc1n09REEZqPONKGo6fT5IY5+Sr+WjvqhLBeDTtn5EF6K5hH
         qS4WnB+SNBON8Xkg9/9uPS7I25SPemrNjfM78xZDL61RbvHHRYJcG3I6k/XArClsoqlL
         AmxuUALDdTLkMB4rZzI9B8YtftBI2n2WB0MJH0dsijNPkjeSGILzzpiLd0UDgzpijp+W
         zf+szcwslWvV2LPqy6KjHqc0IhVHhKJHe7KEnJcShAi54k9X+5D3lKTBtfousWTTEZTr
         fETrDo6Ovl/bKMsu3jckb7YxQiDjX6Oq1uwNw7aJKz/jhrKgo3nOc4SVzgEwom/wFP17
         W/tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnR/2SpomuGMz5Dl5imtIif4CTlbX7me15Ub7gBRyUxAUW1tKinnb315juya0A+RfndajGrxcuowIixp2B@vger.kernel.org
X-Gm-Message-State: AOJu0YxbnDgDIghXM0g+maWdgsZPqWBzTKnRNnv+ZWsBZsyxQ/HVB75g
	DvKJRPUJl1yjnACCfhhqDyY1fzyZoc+uzC5YeV6LMsJD6NUBQVEsT9JAWET3Zdc=
X-Gm-Gg: ASbGncu5ANQzLpJrebGr0bjHHJu+CLRZqeeMhcRM7ErsUU2Np/n+Bvuzbd9ZWYSDDCA
	JWMfpYiD2IWt9KN9UUiHwjD0xRBY1rceylSorI5y3FQ0/FKyooJBehq991QOdz0pVII3i4YyFIK
	7STtIbCujsOgvLebDPTFwaENJzwA14/vg7A2R5Uk40HIGiBlWKzqPtIGbJecZSFK9FX9l8Chx07
	f3hKFrgiZ4tao5gPq8Nin2QdUfpybfBjM4vS79io4RxHfcy1iHvt430LV2OYkUAKpKO8vdT+jO6
	6j/l8DjmVZ5/EFqEVmbFCBMF7rVZsKhIRssH1023XHTR9huBXLDTOg==
X-Google-Smtp-Source: AGHT+IE2/toU+HufXX22qwPZasaD7jOUf2RnZh1MyhP01PfRZenyqlX4Nm3L0S8HlwQimighlo0svA==
X-Received: by 2002:a05:6402:1ecc:b0:5fb:1bd5:f73c with SMTP id 4fb4d7f45d1cf-5fca07eb6dbmr10848327a12.22.1747061465297;
        Mon, 12 May 2025 07:51:05 -0700 (PDT)
Received: from [10.100.51.48] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d701394sm5775759a12.52.2025.05.12.07.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 07:51:05 -0700 (PDT)
Message-ID: <27d93a59-5542-4b5f-bc08-25aa7bff21a3@suse.com>
Date: Mon, 12 May 2025 16:51:04 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] modpost: Make mod_device_table aliases more unique
To: Alexey Gladkov <legion@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org
References: <cover.1745591072.git.legion@kernel.org>
 <20250509164237.2886508-4-legion@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250509164237.2886508-4-legion@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/25 18:42, Alexey Gladkov wrote:
> In order to avoid symbol conflicts if they appear in the same binary, a
> more unique alias identifier can be generated.
> 
> Signed-off-by: Alexey Gladkov <legion@kernel.org>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- Petr
