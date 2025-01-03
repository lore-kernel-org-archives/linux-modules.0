Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77121FBCA7
	for <linux-modules@vger.kernel.org>; Fri,  3 Jan 2025 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735920818; cv=none; b=qnzzeGkUC0R13nDpQRKPr7YyMCrrEz/jcmjr5w5vtF2vtay6zezv7S+zTZiqVPP5rVqjV1MnjCTCZ9C1+E0DAP3wAvXoVs4zy895P8u0BaxbsJyvJH3f65dmlAxS0JxeL250gV54gePBY5Ia+QePEqehHyYhxHTh0yW9gqrbKfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735920818; c=relaxed/simple;
	bh=/r66lPp7CAIainpKkGptJJUNd87lK0TmAVRCPwAkAoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZwMP8MWicdBr0GNDNcxgiGR0w4uxsjWNlHHGnTY2I08PpZwuvQQtfIcCahC0O5GDClhCr7oR0cqp0sFafYUjkI0aj+ywchXV6J0NDkaIMgFptHM2YcPl3hFte95qKJEPFhfg9qq/g8h2Ae5Q63CaBo3flVactR59tcGQAvBVSG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IFzoVgMq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IFzoVgMq"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43623f0c574so84885845e9.2
        for <linux-modules@vger.kernel.org>; Fri, 03 Jan 2025 08:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1735920814; x=1736525614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e0/+BaEw88cbF57VlJ24ibkYz9NORtGOkz1oN9V9guI=;
        b=IFzoVgMqt20LXY2XsYv1EoOOJkt8MPSOmS+w3bxYGiiboBvWDgnsNRV4Pg63jtwqC1
         XocgW4UArRILNKzt7pCHoIus35Q0vAnmslTKm246I8u7PAOJyncQrSj3qXNy+Mp6l8j0
         cXNAFaE2q75UeoJQ4sT3cYtuZx464cXnps7goFxFAtShgON7wYRZEtDWK+Kqm5G0FFMa
         LzWwUOpecEjT+eZVJ3Hl2K0t8rbitk5ZGZmJ5UPytO0FoTVHmWpVDx8DK5slLmbZ1Oqc
         640/iMwbA6vkzoQnynBox8eDERSGPL71hcf7awc68EDXTZadv/CgI2SH0/iwdHvIIB89
         re1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735920814; x=1736525614;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e0/+BaEw88cbF57VlJ24ibkYz9NORtGOkz1oN9V9guI=;
        b=RpKThEkT9Mm0Kz3dsOj7ppi4HsOIjnI1SmNxv4VjVC1Tl4wLu3EpDBqGVMFeEeF86R
         mhUzh+V01z0dJIAi8jePlJNKcoJu1XU9czG2kTjAaK8QT7mO4FBOA+OmYlVpMYn0ipg5
         UL68C6Mr6PbwWAzrgdrFacu7IlbrUsXw5nSSdO+x1z7Mi6xHk0237K82nblMx/5hFppG
         4CgD1gEKRIXOA7Lxybx/OoPEbgx7uZRiLHljl1W8s6vaK3Fun347NZaG2QPCddAIEq/7
         y1P0GbJkQPSu28oTP7OwDKyzO0WFD4PI8weTCmUdNRGCHFxFGKFcG/kyihGVPe1dRxfz
         +GcA==
X-Forwarded-Encrypted: i=1; AJvYcCXCPhsHvPZLzCbC0+Qo1bcQoKCPu2SnrKPLG1bBhUF1xvN5gUBjlL6SuG7C46RWwGrbS4+bF+rDrkwiqgbk@vger.kernel.org
X-Gm-Message-State: AOJu0YzAZkt0xJm1JHyhWMzH1IlMZTmGBPi9EnWzbn/ZoR2BegOexFqQ
	l07BrbI5N6upHpJucYUCvFs28PxIuGL0xHwRJhN81xQNdBb/8lwKvghSG6UcpeA=
X-Gm-Gg: ASbGnctfy+oLdF/HZL+jRg8cPqKtIO4s/P0rsmQiKnIL7MNreRLW1tGbzjczuo+sfX1
	MEIrbXMuUY3YPMj7M1GF1db7AbE3OWoV+S4a98JXDojWKqTeYg+vDbdB5pyhPYi9LbeKQ9sMNp0
	NvBCj75CkA+a73EF2qUBp4MnTV+j6PscjWYxKnasFrV0PZkGY8IcYGt4gzv9Kwvd0MIjeqZXfWW
	Wk2L9ZGiXllgLJuyFCts6WABusMB1NYTv+fVdyq81kEbEoR2SfnCYoeZX6Y
X-Google-Smtp-Source: AGHT+IF6ufCVy5kcxgJVJdCV+23+Qyw0ze7d8fxk8PzaWHEmYpPh2z0klc5PfNTZhi5tqPkJEOdY1g==
X-Received: by 2002:a05:600c:4ec9:b0:436:51bb:7a43 with SMTP id 5b1f17b1804b1-4366854852dmr423005975e9.5.1735920813888;
        Fri, 03 Jan 2025 08:13:33 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b015absm521117135e9.13.2025.01.03.08.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 08:13:33 -0800 (PST)
Message-ID: <f0e892c7-43cd-4310-9d60-1d6e839f5bb2@suse.com>
Date: Fri, 3 Jan 2025 17:13:32 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] module: Don't fail module loading when setting
 ro_after_init section RO failed
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Kees Cook <kees@kernel.org>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Mike Rapoport <rppt@kernel.org>
References: <cover.1733427536.git.christophe.leroy@csgroup.eu>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <cover.1733427536.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/24 20:46, Christophe Leroy wrote:
> This series reworks module loading to avoid leaving the module in a
> stale state when protecting ro_after_init section fails.
> 
> Once module init has succeded it is too late to cancel loading.
> If setting ro_after_init data section to read-only fails, all we can
> do is to inform the user through a warning. This is what patch 2 does.
> 
> Then patch 3 tries to go a bit further by testing the ability to write
> protect ro-after-init section prior to initialising the module.

I've been holding off on applying this series to modules-next because
there was still some discussion on the previous RFC version [1], and
I wanted to give people more time to potentially comment.

Mike Rapoport also recently posted a series with a patch [2] that
proposes restoring of large pages after fragmentation. Should the last
patch here be then dropped?

[1] https://lore.kernel.org/linux-modules/737f952790c96a09ad5e51689918b97ef9b29174.1731148254.git.christophe.leroy@csgroup.eu/
[2] https://lore.kernel.org/linux-modules/20241227072825.1288491-4-rppt@kernel.org/

-- 
Thanks,
Petr
