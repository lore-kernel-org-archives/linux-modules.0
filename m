Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24A829B8E8
	for <linux-modules@vger.kernel.org>; Tue,  8 Jul 2025 08:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961617; cv=none; b=R/aU6w2pEyi4pj3F8LRN8uwCHhPl+3xKsZ6ZaDjjRk25i1OCuJ5P+6rndJuOUVw/9rU13m0PUGZ7bVvaqxIXV8C8QUZUiKlYPc5hOuaxUoh3z4cy9/luLkj4vqyP9ch+7hrdq9Vrz9HCJ8ew5wRpC0fVlVyaWDQDf0QjKdIopO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961617; c=relaxed/simple;
	bh=KsRvc36WADMEMBlhmFW+osm7axtgpd4Z1XQCHNoNoQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IWz+ANe1d0IJJAmqBw+pjjI2t2ZF6YPLn2M1J/HCkvUpbGY8LLXrypofPvYwms0B0vMD6f+G6jppod9zcoi+DLnEHuDY4N00B5Wb5ScZLntykDGLHd0wTO550a+fVn6tuHu4jEIdvgd4RfhuzwKlJFfIbo5/Fma7KlZQDW9905w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TjDeHbic; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TjDeHbic"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so36478095e9.3
        for <linux-modules@vger.kernel.org>; Tue, 08 Jul 2025 01:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751961612; x=1752566412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZdPyCm2AWDYlZEaXQWX2xUKH1HJ494dTDfBl58uctr0=;
        b=TjDeHbicp9aCW47AevAgHOmk2BfzVrRTepmur8vWx3lfn0b4ickkkgPoJFeSfiK8fZ
         0b2ujv5rJWa4CUGzvpD6rFeERYasdTqCGQLgcZFnDwd25UtYWoGvNg80uW/A2svU7q2K
         R4acxSti82HR5uwT8vACQO92gEFGiOimCXZ5YSvqPcG97EcBpHDrZWIsZ9fENfkdMU0w
         rGUgM+ufGi6ELzd0wrEdxLiUHp5QXNygY2yGWlocDJQxSbB/NC9gkBR59XN1z+9VnVji
         crBeFrcIZXADIlX8xylawdFRp5GH/4LGXodkBnW4ob+uT2LIne72TFPrgrCJzeFl72l+
         M66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751961612; x=1752566412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdPyCm2AWDYlZEaXQWX2xUKH1HJ494dTDfBl58uctr0=;
        b=hL4ST23J+YZyOH4/C2Q7shr61nf4bIuwqVnMmXcIj/hfglW27qVgO/OUN3H/sm8T9a
         StIVYqXwwt9jqUnubSvH4ToJSHZ8KrzHs3s3yiwkjuQsJ/ONgSxzgpmjbWCprAUHCakw
         jweWQAXXJ5sv8c/TZcBqDAhaQp0lfAGfSWOF/5t6RWx1MHkbEwLJeKFf5DuvrtP2ye7Y
         02CNGdsFVDOvZE1EQx5mo2FaJULF9xz5z9s14tdVEp8FuvvOAojoaQiQL6X179gxNWJP
         KSZwKLDMOpFFO0Tg7Y4Ud/X80zwTuwOfDOayYbnyHKOkBplKBr9v2Sskj6zhTlZXvZsw
         CTXA==
X-Forwarded-Encrypted: i=1; AJvYcCWg9TsL5C1gSHFq67HgXek1lrbCY95TDLc/7FwzsxHaItgJ90cNnGW1mUyBoe2lS9pqaj8SpPQxBEJVPJbX@vger.kernel.org
X-Gm-Message-State: AOJu0YyomHwNq0fk+abvNoSDXspmiRYbwWLl1G0xby05okQz0OvySDYK
	BueuDeR1TwWVOsvR/UlLp2ZUmHCx1yZ/baj9USQMEwYCkAaJHtHYwqMoDsPhQzYiBTc=
X-Gm-Gg: ASbGncv3RrBfQ2M+ZL466fz+Lv048hFSHj631E4bE2m46Z9W2sIuup/9RChUxoki7Ef
	AF8fP4uyNJo+Ptop3yVHqttygA3CkTiaZdfyEgeTM9V4kkCMrBeJPua097eXL+4xm0WkTfssw4a
	4pU2NFu4/gY3kdmfS9C/UHPmpEWqf7A/gXbrys0Gs4hXwNJJzUlKxYvFpE0EAfoIkdMbhzREdDf
	7mx+AlLw2smMIX4IhZ0qwujtUMxbXjZJmPPWU0zKn1pt1Zyr2zhdH/eTuwvjFnmOmrBJ77EGUTk
	llFr/64UWsFdiErKlwrqXRLv5DMsxlyM4a7VFd6fb2t9LLlswMp2kxawCA+mfm8czg==
X-Google-Smtp-Source: AGHT+IEsA/z0OzbHwBngjkFHy4ad7foMqG15RG4ohIVwHNUpcdFHggy+ThQVZ9RoheLwCsuwoPnrdw==
X-Received: by 2002:a05:600c:4686:b0:442:f12f:bd9f with SMTP id 5b1f17b1804b1-454b4eb82f0mr147958165e9.27.1751961612040;
        Tue, 08 Jul 2025 01:00:12 -0700 (PDT)
Received: from [10.100.51.209] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47285d3c6sm12359083f8f.95.2025.07.08.01.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 01:00:11 -0700 (PDT)
Message-ID: <15ed6295-87bb-430f-98ef-b856752c23d0@suse.com>
Date: Tue, 8 Jul 2025 10:00:10 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: update Daniel Gomez's role and email address
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.com>,
 Sami Tolvanen <samitolvanen@google.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Gomez <da.gomez@samsung.com>
References: <20250704-add-dagomez-maintainer-v1-1-5fc32033c51c@samsung.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250704-add-dagomez-maintainer-v1-1-5fc32033c51c@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/4/25 9:39 PM, Daniel Gomez wrote:
> From: Daniel Gomez <da.gomez@samsung.com>
> 
> Update Daniel Gomez's modules reviewer role to maintainer. This is
> according to the plan [1][2] of scaling with more reviewers for modules
> (for the incoming Rust support [3]) and rotate [4] every 6 months.
> 
> [1] Link:
> https://lore.kernel.org/linux-modules/
> ZsPANzx4-5DrOl5m@bombadil.infradead.org
> 
> https://lore.kernel.org/linux-modules/
> a3701a9a-5b42-4581-a150-67d84601061c@suse.com
> 
> [2] Link:
> https://lore.kernel.org/linux-modules/
> 458901be-1da8-4987-9c72-5aa3da6db15e@suse.com
> 
> [3] Link:
> https://lore.kernel.org/linux-modules/
> 20250702-module-params-v3-v14-0-5b1cc32311af@kernel.org
> 
> [4] Link:
> https://lore.kernel.org/linux-modules/
> Z3gDAnPlA3SZEbgl@bombadil.infradead.org
> 
> Signed-off-by: Daniel Gomez <da.gomez@samsung.com>

Nits: Link tags should be single lines and their indices at the end of
the tag, see Documentation/process/5.Posting.rst, section "Patch
formatting and changelogs". The second link would also be better if it
pointed to the initial email in the thread.

"""
Update Daniel Gomez's modules reviewer role to maintainer. This is
according to the plan [1][2][3] of scaling with more reviewers for modules
(for the incoming Rust support [4]) and rotate [5] every 6 months.

Link: https://lore.kernel.org/linux-modules/ZsPANzx4-5DrOl5m@bombadil.infradead.org [1]
Link: https://lore.kernel.org/linux-modules/20240821174021.2371547-1-mcgrof@kernel.org [2]
Link: https://lore.kernel.org/linux-modules/458901be-1da8-4987-9c72-5aa3da6db15e@suse.com [3]
Link: https://lore.kernel.org/linux-modules/20250702-module-params-v3-v14-0-5b1cc32311af@kernel.org [4]
Link: https://lore.kernel.org/linux-modules/Z3gDAnPlA3SZEbgl@bombadil.infradead.org [5]
Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
"""

You can update the patch on modules-next, no need to resend.

Acked-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks
Petr
