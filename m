Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DA61D6DB6
	for <linux-modules@vger.kernel.org>; Sun, 15 Jun 2025 12:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749990020; cv=none; b=HtdnG4MdAGBHduKq3ZRBVW4QRZlMNSXV+KcZO0zetU9QcN9fozkH7i9L59QbghH9qTEhqMhwvVPwe8lx4k0HiE5aKs+IF5KLzFQNUuHkV4B22ciz+W2PumZQr4AGJtyAVejtfpBCcGuflkFypwznpK+5AAozKJsYm8mHCP8mhb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749990020; c=relaxed/simple;
	bh=wIhvCyHenbk/sVdlCti6MRYC9lpi+XF//kz3NqOCkXY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ckF+PEO8ith4QhUaz7YhWIbr50DfmbbRZ9POtYJ2l+eex0n90QNVINzq1uXKt3tb5dStTQaEdS/c7UoXhTsUmVdWj79PEhAgYw9yVy57hPd9Cg6BH4YSKv88NxNVzffO4OhsERpE52lxV2/oaI8alkno74Yi7IxWgfLfLIJoqGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNOAMzJM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNOAMzJM"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450ce671a08so21542445e9.3
        for <linux-modules@vger.kernel.org>; Sun, 15 Jun 2025 05:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749990017; x=1750594817; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJJafeHgufsOx/lcevjPumN03tcLip0acs6zBF7M3UI=;
        b=hNOAMzJMmSoFdJQj8ub/kwqKJjq7SQrAm1trjDUUx/dk4ZzKg38O1st62HjCJnIG8K
         Ssk2hdxOEEI6UGIZUI+cCBG2CzRwMECJ8EK5YsQqeT6wuxey/xxt3miSIn0xiXRehpZX
         4GROtuxAdU5Z7CoH2YdMbni/Ijkbz649MHN3YBpdijfCX1XQnrBaWO7gEmtdE4bU6uuz
         jPbm9ViLPif1StYBkSmgGTQbvrtHrVU+FqVovosLdJbbgERRW6IgzaIAF2rblA4gU1bW
         vAxfXV6pH77EvB6z8Ivx3396bnzDG3IpN2XoDkFDP27KFSkzrotEKCj86j4L9xqWKcKb
         9O1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749990017; x=1750594817;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YJJafeHgufsOx/lcevjPumN03tcLip0acs6zBF7M3UI=;
        b=oV0wRRUa72zamJkfLR88JoOEDbmrLp0oM7LFoIhpuA/XPMQKb9/6fCG2wtWJDWvAYH
         6xEXnkZ5ivVM7bej4EFyvP3RGurt4S1rzAc4TopR45uKtK0E3+GDVzAra4M5v13xjkG9
         sQGiW3zIv/OEbxUTOAhCKnEfNdO+PV2S75QZgaghgHAlAaW36Lpd3bFgZdNG+quAIoaA
         50KbrUTNdfUD39cvZlK5mdg8EhTGfj1xGL+GrUwtVbjomZwTFG3wzsGGWm+JMU5BE1HS
         FsdoUq+SMZ/dsTO64DtKjr7nCPBW60P/rP5Hv70AVUdhYj5CkCpCIgLv7CeyJeAlW9TB
         /yKg==
X-Gm-Message-State: AOJu0Yw80667Wd/9SQv/2jgE1gr6UzWfZ8wMQi5FAx2CRckbFF8NCLbl
	qLJGJ0J0ameYTDmbi3rF3WRfHAq3m3dmdXcf1Miyjg1jc0Dbwoh+B1bZbPyxPAi+
X-Gm-Gg: ASbGnctgBDHlH6EjDNczYakj0C1rJpMg/jRANhbSuyURScPU9VU6N+1loXgOBCwDSkf
	rv03TgkYwnclL1R7ZrIRhQC9k2oC4MMAoMoMNVbVvwVuwZpC4qqbCyAeFAKzS7IJDy1JtyAOw9W
	kuq5oK8P6hyaPXWZdGPE7Q/wOK0DnZJfYVl2uVa4E2nSS0kiyxz9bhsFHdGw5aFuJ9CXnGZRyjY
	BxVSQdcMzqz4mqq3wNkCYJ4oZdO5U05ih+CW5SrCw/ikSSuW2CupcYwYGSpAYQ9I3NZOBO34mqZ
	OwfEIHRwayULIxtz4hxNMESE9adUk9xAEO8p9y40NIyAQ4fI1sYp611zQAr47fPr+spuSTPXwsL
	HuSmkKTGubdd8zAa0NrWs65tcGTYTquIpMgUpsw==
X-Google-Smtp-Source: AGHT+IHgDm1XVbAr6Q3ZSzWVJwq7iNrxHurSLIIOWQMzdAJ2h7Rpp5mIh8XgQ6yuyDrTW9kPwoNbwA==
X-Received: by 2002:a05:600c:470c:b0:442:f482:c429 with SMTP id 5b1f17b1804b1-4533caf534cmr56686005e9.8.1749990016615;
        Sun, 15 Jun 2025 05:20:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:22d:4d0:1ac0:4dff:fe8b:a3c7? ([2a01:e0a:22d:4d0:1ac0:4dff:fe8b:a3c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e2354fbsm106242075e9.15.2025.06.15.05.20.15
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jun 2025 05:20:15 -0700 (PDT)
Message-ID: <a1abfdbe-5aee-4307-abce-5fe15bff6266@gmail.com>
Date: Sun, 15 Jun 2025 14:20:15 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-modules@vger.kernel.org
From: PF <pierre.forstmann@gmail.com>
Subject: How to run tests ?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,


I'm trying to run tests on Debian 12 ou Fedora 38.

Following command runs without any error:

meson setup --native-file build-dev.ini builddir/

But following command always fails (here on Debian 12 but on Fedora 38 I 
get similar error)

$ ninja -C builddir test
ninja: Entering directory `builddir'
[0/68] Generating testsuite/build-module-playground with a custom command
make: Entering directory 
'/home/pierre/kmod/builddir/testsuite/module-playground'
make -C /lib/modules/$(uname -r)/build M=$PWD modules
make[1]: Entering directory '/usr/lib/modules/6.1.0-37-amd64/build'
make[1]: *** No rule to make target 'modules'. Stop.
make[1]: Leaving directory '/usr/lib/modules/6.1.0-37-amd64/build'
make: *** [Makefile:23: modules] Error 2
make: Leaving directory 
'/home/pierre/kmod/builddir/testsuite/module-playground'
[0/68] Linking target testsuite/delete_module.so
FAILED: testsuite/bb-rootfs
/home/pierre/kmod/scripts/setup-modules.sh /home/pierre/kmod 
testsuite/module-playground
[3/68] Linking target kmod
ninja: build stopped: subcommand failed.

(First run says that the directory "build" does not exist. But creating 
the directory does not help)

What am I doing wrong ?


Thanks.

