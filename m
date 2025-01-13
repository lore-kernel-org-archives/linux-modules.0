Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A4D22C9F3
	for <linux-modules@vger.kernel.org>; Mon, 13 Jan 2025 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736780958; cv=none; b=E2vaTxyofaftjV/SsYeLvMGnVDphkDKxfWfZ9eSThH+2kMlkp6JhOBOl79xuwvNjIWZvBpu9QEvQ7827lrFMwCBPpXlnS38wkoPuSv3dlLB6VqrrQ4DyKtTlOc5OAANORN44USiN5ngn5SSEg7XkD2iuOMqdaRHwA8VhXTDWRoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736780958; c=relaxed/simple;
	bh=kRhkE5n7v4Whpf8fVWtjsSx5QcAs1w8kpM+1riSUPMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kv63BPGTSI+Z64IhBlbXPg9TiFNPcHekO7ByApRDJCLCTjvPbVzj8BVsG/50yHDbOPeUz6z6o9DZuMIM8nO3ThMw1++Rgc17bHHFTAcJaNSqTkXeIWmfIIEvO7QcwPmqccDYZ5WvIBiuLVRxJPuLmJRPPCD7g3iHgskceTuIYYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ezS9Zan6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ezS9Zan6"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4361dc6322fso31019315e9.3
        for <linux-modules@vger.kernel.org>; Mon, 13 Jan 2025 07:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736780954; x=1737385754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ObLtarfixbuoeU4sYBvXiHlMBkt4zlHaerO6eMC7G8=;
        b=ezS9Zan6aFB4fwtUVr+qGWMrowQXWc4kz8fChye5r0blUpdRTv6qref1NlbsYkcqjB
         POEGkDcCgzKItEhlEjb9u07bLwuX41mcm14ZJFod4dyR/7BRNZtcQ66g0GN4692ssqoE
         MMDLRhtqiTDWeTaMQw0X8vhWa2sp342h83sW0JL9lzb2l0dpZBhL45j/iIndd56GsaxG
         WzyvE5yRM7r9aO+9lqlrNOBHEgBrsG/476rGPiczl10PeTfT5dlJX+T5kYqXfFW6LGEW
         YdnwCjsZtneV3xbZMgPZ76b4Koj9cgxwibhszAZrTfMorrKByyzS/a9HrVZEEs9aHlvi
         qWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736780955; x=1737385755;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ObLtarfixbuoeU4sYBvXiHlMBkt4zlHaerO6eMC7G8=;
        b=uMvRO4ZI6UMvU4Rg33E5w21XCL+6R0KusmRctUtksx5qVLPiw4m51MymiUvrCGS7E+
         r7aRRPirYrqb2om1wDe35z2BomstJyvWIDcnBPukRtssU3ZCKKv7EmDzjOLXABM1s5Uf
         G2VpbXf8xUl3kloNF7jRuFCrwtq89Hjgc02y3mYqhg0PwTy6AB7e9uYYx2ZnHvHbvZmH
         47ENmvQ7e5ulcXx9wdndWrJdopH86E/RlvAeoVDCuYZizJ1BHwjXxG9T3G8mgUlFhd/y
         5FRbPndq82qRrc/ldDt8pqhC2x96eFik7FyHqWUwklJarFd1FEa+SLHtbaFqu3gnVLLu
         uAvA==
X-Forwarded-Encrypted: i=1; AJvYcCWyILV6rER9cUphxS9W9fX90YHonQRRNfrRxE2SQgfe4NWcii/BqG47px9ZBvJ+cBXVegkocZDrMRB3VkDB@vger.kernel.org
X-Gm-Message-State: AOJu0YxuYC7zp4+0X/ur7YuOCWnAKEHu2NJ3oVjL4spxr2T0LA3dCSUo
	xvAgoywCIEdTWReEhNfaqYtd34uuu25SNKSlPict8lwk2+fsHTull0g9rSEL+/GtNayesOHDOfW
	X
X-Gm-Gg: ASbGncuvnnF81tTpXImHHCBq9XyRT8aMRtuqPZFIAJluTAEqwtLUOko3cRIexCQIO0k
	XRih1g1qs5HnQmV6IKyqzsLg8K5+Op3zx7pY6utwOMCJOauhVix9EjF8sskf5kjap+FBORx05Du
	uEIm0Lgqjp/fzY6Uow9zjrxhJLSf93BbAtBMwhBBOZN/9Z2AwFqy6pwBwOAUQ7f9MRD4uv1mGO1
	UfymboXlNtC2xEmOxVNgzRD8BqZpegJwCpB/rCAzxyVyY7e9lo8T64Hdycd
X-Google-Smtp-Source: AGHT+IEsbWMFnleSfxZtUy8qfCZDcHp6iHBDwND8NHE6D8XDA1Ya1X/7dUhnhfiTLdJ7vz3kEw7s+w==
X-Received: by 2002:a05:600c:1c14:b0:436:1ac2:1ad2 with SMTP id 5b1f17b1804b1-436e26c0400mr171652465e9.19.1736780954585;
        Mon, 13 Jan 2025 07:09:14 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2dc0f69sm179356045e9.13.2025.01.13.07.09.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 07:09:14 -0800 (PST)
Message-ID: <ebbd79c2-50fb-4d9e-aabf-a55ea463c494@suse.com>
Date: Mon, 13 Jan 2025 16:09:13 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] module: Introduce hash-based integrity checking
To: Luis Chamberlain <mcgrof@kernel.org>, linux@weissschuh.net
Cc: Arnout Engelen <arnout@bzzt.net>, arnd@arndb.de, da.gomez@samsung.com,
 linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 masahiroy@kernel.org, nathan@kernel.org, nicolas@fjasle.eu,
 samitolvanen@google.com
References: <20241225-module-hashes-v1-2-d710ce7a3fd1@weissschuh.net>
 <20250109105227.1012778-1-arnout@bzzt.net>
 <Z4FyGEXBK4EUi_Oq@bombadil.infradead.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <Z4FyGEXBK4EUi_Oq@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/25 20:16, Luis Chamberlain wrote:
> On Thu, Jan 09, 2025 at 11:52:27AM +0100, Arnout Engelen wrote:
>> On Fri, 3 Jan 2025 17:37:52 -0800, Luis Chamberlain wrote:
>>> What distro which is using module signatures would switch
>>> to this as an alternative instead?
>>
>> In NixOS, we disable MODULE_SIG by default (because we value
>> reproducibility over having module signatures). Enabling
>> MODULE_HASHES on systems that do not need to load out-of-tree
>> modules would be a good step forward.
>>
> 
> Mentioning this in the cover letter will also be good. So two
> distros seemt to want this.

I'm aware that folks from the reproducible build community have been
interested in this functionality [1, 2].

Some people at SUSE have been eyeing this as well. I've let them know
about this series. It would help with the mentioned build
reproducibility and from what I understood, it should also avoid in SUSE
case some bottlenecks with HSM needing to sign all modules.

I agree that we should make sure that whatever ends up added is
something that some distributions actually check it works for them and
they intend to use it.

From the SUSE side, I can also support that the feature should work
seamlessly with the current MODULE_SIG.

[1] https://lists.reproducible-builds.org/pipermail/rb-general/2024-September/003530.html
[2] https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/merge_requests/1

-- 
Thanks,
Petr
