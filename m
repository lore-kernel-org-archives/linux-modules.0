Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A43578F24
	for <linux-modules@vger.kernel.org>; Sat, 10 May 2025 05:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746854724; cv=none; b=OQV6ZRp9tgWUG6j5VbMR/rwst9KgLz6TqQFHFHHtPZxdwemgLg1NYMkUW4QTjhiv1teMZsA2+tHGue8G0mxPZQO4sT1KId+TbXT7mwfcElfxj3VK777pMBLdFdossCOIblRsohMFbURJmQV+886g0xMKQ5rpzx54u1OxAgV/PBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746854724; c=relaxed/simple;
	bh=wnSpCN0SlQvDTbj5w2gtJ0EQde4v02WPBAxkEXxIs6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cquOOUQPiLLJU+jStq7iUzA8TqG+h9LgQ1LXpTkGRqW5cUqpeZKfOxh7S+R6Kn3wxQGKfYb2ii7Daf/F9QHRvAC9PM1LKqoig00bNfoQei/aeDhtnOTTY86IsVgAVZm4oPTmKnaSDnxCwdoml+RWxBP7zflilCkwwUEBb0iQOcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CFJywd4P; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CFJywd4P"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5fcac09313cso1984627a12.2
        for <linux-modules@vger.kernel.org>; Fri, 09 May 2025 22:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746854721; x=1747459521; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NAPjzM4sAakR9ZKfNitQt3KlBJ5tW4NoE0Hpkn5Csq0=;
        b=CFJywd4PeoeDdFo8Xj8bAnJVGpsQFkxoXW/Uh9vS/F5YJVsAJJSQyQCYrTRKgTwG7H
         k1hdKWMCmnviLiNBE0uzkmSEcStLLjFOtM5C4ymx50negBRtgCharL2XT1kPt3JJSH0E
         4KoK9YY2rL+1fUBsSrtRsYRuetU3CMpOJLJo21sjf8Y0iEESTSrtjXMQ+fwU5xtj0PeD
         r630MiNo4/No4dIC36wWUT2mTWIRrfBDwM9J/jJIpZUHiU+QMsWYpg8It0DyKUSius9f
         Tx8EDMBjf/RlYs+YjOaxhDLKIDtGoLmL5fXM3RXt9IGKpL6gBpBq80PIZU/VfnC6Efog
         Acxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746854721; x=1747459521;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NAPjzM4sAakR9ZKfNitQt3KlBJ5tW4NoE0Hpkn5Csq0=;
        b=rOYLGrPESgGR8dCN05x3GniP5bcHSQ7t/8jCE1FTXGeVF/0BWEs15PXLMw6N8NKAUE
         k/mO+mbbgWEF/aV9T4PXNZ76YYYnoFKzTtbwAkb6uNxFgTRTec0Vnad0pz1zOoBjoaUB
         5AbNpogNMPNkzksI3HsexDtpqxHsejQJlJctcD1sVfHeo0LpGds/VGhWWEMkX8bjFvEA
         uzLGzYP/1HLp/Krbw9evEaEUeoq11Kuj9IE5VfD9rrHlHKoIepWJri45djxBGl0BsGHA
         MSJU1k8b+ZiGzsq9y8emTpYEEkVp74SHFCVJtGla5B+BIXTeYroIXZIiNXDehdugqs2k
         NDwA==
X-Forwarded-Encrypted: i=1; AJvYcCVeTXqzPx9XmftkMgwIAhhEcjrY4Tg1OR8KdLdDSPNVgxdhGYqD/A06oS3JmJKeY/5H6Kh5cbxU8ypczN9D@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt0s/uSX2daTXg/HIjlae0zfuf1DjRE47i4CzKWWwiGcyMbuq1
	vXhXgFUVPOQEfjjUihHVT2JwxLP4sqSvwiNc3wUiGlAZUs7vRlZlvnEfHteB61E=
X-Gm-Gg: ASbGncud5QNaMZ3k7fWCuCUsdofDMoz/W+3afEqCvW5Xpx78Geoi80tsGI90a+Sy+MT
	8KEEpMA5UlfsKwbXh3ovKnCiMiKIxb48DAaFCgKZoQXHWFS1gihFz6ZYFFcvSr/P9XKMRUqoY9u
	91I95SarTWxkQRovY645XhJRcEIXibfRD18pNQuuYE7fOXkv3eN8NRX9uXvSryyhY0MMy6fr/fI
	Nu5dkdfaMkRLE83aSiTB0OOJSkCa3ga9lYLXj7MlgvclxvET/rq1ps6m+x4U3wt4+i5iEk/wEWy
	Js9TCDswFBnWpC7vRyIwU00maKfK6E/CBXea/4fmrRdGCW6madG39A==
X-Google-Smtp-Source: AGHT+IGRmRcIxaVSii8qJ1fAKjH2Bcn8Hmyb1tMv2VrSZGKJXfOxDkWWHmeUJttXj/PSzLp0og3pSA==
X-Received: by 2002:a17:907:8687:b0:ad2:3efc:dd7a with SMTP id a640c23a62f3a-ad23efce2b7mr34772366b.4.1746854720571;
        Fri, 09 May 2025 22:25:20 -0700 (PDT)
Received: from [10.100.51.48] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2198532d7sm260830366b.170.2025.05.09.22.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 22:25:20 -0700 (PDT)
Message-ID: <c804cbe9-3777-46ec-9df2-db76c1139137@suse.com>
Date: Sat, 10 May 2025 07:25:19 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Modules fixes for v6.15-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dmitry Antipov <dmantipov@yandex.ru>
References: <0e82be0f-a305-4aba-b9ab-79596f595277@suse.com>
 <CAHk-=wjNj0vHh9v6-LTrbgtq=o6OS+RN3u3m03nV3n9V+urGtg@mail.gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <CAHk-=wjNj0vHh9v6-LTrbgtq=o6OS+RN3u3m03nV3n9V+urGtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/25 18:19, Linus Torvalds wrote:
> On Fri, 9 May 2025 at 08:09, Petr Pavlu <petr.pavlu@suse.com> wrote:
>>
>> The fix has been on modules-next only since yesterday but should be safe.
> 
> Hmm.
> 
> At a minimum, the *description* of this bug is garbage.
> 
> It talks about an "uninitialized completion pointer", but then the fix
> actually depends on it being initialized - just initialized to NULL.
> 
> I do believe that it always is initialized, and I have pulled this.
> but I really think the explanations here are actively misleading.
> 
> Because there's a big difference between "uninitialized" and "not
> pointing to a completion".

Right, the description is in this aspect misleading, my bad.

-- Petr
