Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E0F226193
	for <linux-modules@vger.kernel.org>; Mon, 10 Mar 2025 11:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741604843; cv=none; b=Eoapxbw4p36uDY1Y49Wt06FonQ7P8TWMpPcifY9eERJhbVMs26yFPJm6QYw7pL6/ARrrt07Fo5T+6btT3432vd3POBlT1BE6FczFZbRV6DvmsdHgmAEI5q9ntqZawWTTf6GY+E2eZTTpk1Z3+7PwrPNmOd1rIBi8WzZUrpqHbuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741604843; c=relaxed/simple;
	bh=E3SkaDiyXKVedK5kf/LG+F6Dw3khT24RClCdqmT6xxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uDyuTa8qaTi8m0ci/lwJ8Bj9xzkQGS5q3OTf8Yc+yxjnNu3WZ+QsjFDKFlP9FKmrJkTYmcqd2Bv6KB03HjkB5DQSpg0pCeHUAmLsM4L4Na6cmA/kvAKxohIeh4xJva0MGBmFMTqWu4ThAa9ngCSJDtFcwpiK1itvLyj3W7iq/eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O/TaV/xJ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O/TaV/xJ"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38dcac27bcbso3305336f8f.0
        for <linux-modules@vger.kernel.org>; Mon, 10 Mar 2025 04:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741604838; x=1742209638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JBcgqyPlbosjp2zy3+ac6vsF4qpWptDr9INnNUVK6yk=;
        b=O/TaV/xJ5qCwzereSakC8r4boyJoWxcCHOqZ+eK5aWyGoksPS2T936FrSQXgg6DAl6
         8StyBZEN7r7VfqcgRXSR+zmPNIq5UvurImiM6nT3YcheZq0NN1RcS4Rdz6nhzKXjci9z
         NJ5zCIqTlIDMbvRHBdVDmjfzzk9V1+MEHSCQ8HKRcsgXkzlq3hqogaHlJCqcmVshk3VW
         F5zGaqpTUI5nBZ/Oqnx6azJXuq+fdK8l5crZv8l42ldrDuekIz4ly02+q+S4YrB85d3I
         VZ2qUuwSzUcPguvuLSzKjprr1qpHojW3tRFqgQgbUigCYlDKOuJ2/UmvKIPCXIQNYP40
         hFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741604838; x=1742209638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JBcgqyPlbosjp2zy3+ac6vsF4qpWptDr9INnNUVK6yk=;
        b=i8iELxeBYrzyHOCo8ETPDhCuSNFcOCQ5gcoE8Hor57agnvppf20m8ShgrYJaqBbYty
         OKLcDpZTHWZLIy9IjdznXtP3LlRGOfVaOf2KOhxwhXzHWXncB8OCgWY6g2mO/SF1/ANO
         VuPxBQnakb//qN2NhY/Zq8OWrXeU0lHzwFWakYgyWELWmCGOse7djnloIV0szwfulaaz
         3gu0cJf5vUjTB+ky3UR89eDcInn+mRB2LktY5S6hKE/wVRTOzzTYQ/t6ZHXVa922AdZE
         cfodvGvbxP5PHwkqpySjq6Uz15i3awqHzUsDBcbMRIMcfYqt9XGPS9QJ1F/FEmNSrtN8
         iJOg==
X-Forwarded-Encrypted: i=1; AJvYcCXBEeIe1jw3so+pSZnXaNcNwEMyptM69aaXTShTk29V9uXogJq/eWDCCAjZP5hJ25x/0B5bA6eEiYXfmcTK@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5yksFXXPUdPnqvGIAKTHSxjrBx9Gg1u4hDzTwxTB9AFR9wEYU
	4HYy/ifdXkDVoYaFgmNtrVbxcDaUxFG4edwbj6RfRG7GgvQqtLZuFb1OH3huH0E=
X-Gm-Gg: ASbGncsthibrtjiGGGhQYAsRprlE2vjGfFcMDnir1ZoII8L+Btp+lknyhwHNIlCMWza
	aCim3QkVMnVG0dKGv5u+3QYzBPisHb1n8WTL3QT3fXxW+vddi67y3Q9zWoFILn9BrO4u3i4bCII
	q88iSPULb07Y45JyJc1uXsDHTmVJCbxIgy4axvSemZ/UN/vclT56yu1441UzIgqGN2zqb75hNYS
	s/4qzXGpKZV3JvyNWACv1ULkA+B31niMQN4XDnoGQZIEI817ywZQdJ3aY5jKpdSMj5NRJ7VqIoX
	0d8966El4XeU0Knf5GyyqFNLVUogsQAmyaAqa5OBhY5DDd8j
X-Google-Smtp-Source: AGHT+IH9/rdUnizpqSBA8HQZRuo5gzzbf5lJb9mjbnEeKpVc0nSuueyiE3WfSrFLVop5GR7AmRPlJw==
X-Received: by 2002:a05:6000:184b:b0:38f:23c4:208c with SMTP id ffacd0b85a97d-3913af2e472mr5183779f8f.18.1741604838405;
        Mon, 10 Mar 2025 04:07:18 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cfa7e4f36sm24039495e9.40.2025.03.10.04.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 04:07:17 -0700 (PDT)
Message-ID: <975dff84-234d-4fad-b15d-0427672785d1@suse.com>
Date: Mon, 10 Mar 2025 12:07:16 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: Replace deprecated strncpy() with strscpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-hardening@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250307113546.112237-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250307113546.112237-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/7/25 12:35, Thorsten Blum wrote:
> strncpy() is deprecated for NUL-terminated destination buffers; use
> strscpy() instead. The destination buffer ownername is only used with
> "%s" format strings and must therefore be NUL-terminated, but not NUL-
> padded.
> 
> No functional changes intended.
> 
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Looks good to me. I've queued it on modules-next.

-- 
Thanks,
Petr
