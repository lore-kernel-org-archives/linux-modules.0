Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BF514A0B8
	for <linux-modules@vger.kernel.org>; Thu, 22 Aug 2024 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724322930; cv=none; b=Fj/N75x+pPMmQS+SWEoY5gkAYwbfoGE4s0M36kUwMqTXXTTeOtdxsH7jY7b8G2OcMnW9sVCG86R6ooarwkpwLqEfs0bkWBIxmpifH8lvjqSNN/KEjlRn7oVW1vzMzaZTFqIm/IgGbH23KsPT89rGEwQuLoF3CRGZVlLAP6XYGIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724322930; c=relaxed/simple;
	bh=Zr7XPwrtEk3qtd+gx6KyV19j72eTMSccWfQQdkVH9B8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jbKoCwfL7HHMWaJ/u6o6ThulEbI37GZyJhvWJ6T9CWTCI+JYBc1/g7zGYmyZBZreuS63LMtGCIS6s/YmpkNXYMZlr5ym5ULmshSa71tulb1XLqyA0JyRVa9P+twuJKjHF/1UkoJPyZ5j+Wuw4SW8VHGJ6Ev55KGfBnOhAsY0c9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UfQLBYi0; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UfQLBYi0"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f3ea86377aso6414411fa.1
        for <linux-modules@vger.kernel.org>; Thu, 22 Aug 2024 03:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724322925; x=1724927725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/p6i37or0QISD6fmH5m5OZHLkmrLXz/r/0MMJoGQsE0=;
        b=UfQLBYi011JLpNa01J/SQMCyA8Rzw729b54O3xxekLSR57OcD0L6JXDL5TLUYP9fq9
         wgNveyQkREuhRPzA5gD/DiHNW8QFa5HHpK2Smz/sgbvn/iMUoSFjepm29FJDbO4ljxG/
         7Q8FY9mAl5x+lHw2yDF8SxPK6R+ungv2MjKbGt9WA+xUMKl2tZddfr17fRbbURoRjreD
         /xxV/RD6vHVCYjtfCi7/SbWi/iIqbjyFVHRIdBEs6K32DauDeF/smsvfXhjRjmGivbBv
         SM2+mWjq+1OtnnBva6emZ7hCt+pcHe8eywmeUWTySOpchDRpREStV2UeGkSJ5wU41SEE
         FwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724322925; x=1724927725;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/p6i37or0QISD6fmH5m5OZHLkmrLXz/r/0MMJoGQsE0=;
        b=WvQSzJBu5Otdq/Dw2rMQ1DVczCqKtmgO9pi4MGSkR7Yl/bustd6cf1sdxqKtldc9vB
         xou4nodzAqfr+NenZi55QoKy9L3gdCPRxhH5YBDnViYrAyMxn7wcyqWi2H9TzQcSFVPr
         fzROfchZhXSBlocSYET+TpqA3zgFnP/FmPf0hQxEwSS2J6KcoWSSCyuQfe2qd7Kvroam
         4E+iSkkOO8kWgDFou4AgYYWkEQBKgqTS7csPygIk6ClQj/UTGxfO7JCAg6B6LGTXLmZF
         Sdxqb+a4PqP1oY2MOXUfC0iQBh2sBa/LPOFHgyA3Odc1uU5liJ5kQkrLoVd5zVlszAvB
         OfRw==
X-Forwarded-Encrypted: i=1; AJvYcCUPSfAB0wzFnIlDlRitCRiBwVaTtmKhx79DqO8WQaZo0gCfpWgBeJvXGv8A8wZngG06mcFTwqkVjqmNsXYo@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0GM/ZIoWXktm43j5ibd3uX9aTAP5SqsU7xsSXvrWdR3NygCSt
	OVHHmC0oNoXKUtl3AvcF6ElKZ328rklxrMc2jPpddpCkIe33l0UXwCQavbeCu6MaV2oYfZNokl8
	+
X-Google-Smtp-Source: AGHT+IGdsE1iYvV40D2msT5q26R9UmfrcxBs0mu8KXtbUxmxjfHILnwDSACtQevE3PyiAHKFLGBQJw==
X-Received: by 2002:a2e:a985:0:b0:2f3:ea86:3727 with SMTP id 38308e7fff4ca-2f3f88941e8mr35284061fa.24.1724322925314;
        Thu, 22 Aug 2024 03:35:25 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3e9540sm749547a12.41.2024.08.22.03.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 03:35:25 -0700 (PDT)
Message-ID: <a3701a9a-5b42-4581-a150-67d84601061c@suse.com>
Date: Thu, 22 Aug 2024 12:35:24 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: scale modules with more reviewers
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: kris.van.hees@oracle.com, samitolvanen@google.com, da.gomez@samsung.com,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240821174021.2371547-1-mcgrof@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20240821174021.2371547-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/21/24 19:40, Luis Chamberlain wrote:
> We're looking to add Rust module support, and I don't speak
> Rust yet. The compromise was reached that in order to scale we'd
> get volunteers committed from the Rust community willing to review
> both Rust and C code for modules so we can ensure we get proper
> reviews for both parts of the code and so that we can scale.
> 
> Add those who have stepped up to help.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Acked-by: Petr Pavlu <petr.pavlu@suse.com>

Cheers,
Petr
