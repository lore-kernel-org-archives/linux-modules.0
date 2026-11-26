Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795690501;
	b=RTBAamnuAOoGPACD45VBvIS/APpotEbMJTuNS2puGV1Gxh45QZvRunTWRiC8a5u56iL8
	 TxOlKtTbg756MpIPP3YgQMw1VxBLqEswEsp6FBVLyCXSJ8ndGLVkWp92OXNVnrpP5BIvA
	 NOYvuusBZ9KZRAzn25sMpCy8yzwwp1RY45yDofbWfnA0c/zEEcD40XqqYlY7NrUh7fuJ/
	 nOyFNLcHK9mt8HkfczTaAFts3GkyvVeCKA+ydDw6nzV3dnHyMw5dEvewbHVb/he3mHUej
	 WaoPPvMR9URevWrHUg8gkk2diYQOnPBgu+4PtG9uwmbuh8AGaNDCxiEuL/wQ1kHJzOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795690501;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=XCBi/ONXrkZ6TGvyvXiNuOf74OM2pCMUMGOrobsrG8k=;
	b=UPrDU1wWzDWCDJRvLppMPIHWluIGBPQShOwBl5O9zvbWIG+2qtWIxSLZd/dRN98dQmd2
	 xQB/rk9+CApI9lHxG4o+XsvoCfMUHFnqKqQhnmBIQ6PXScBKyUma/5dZZ87BrCjVser9a
	 4KMojbEzZGjBPdxIgVaa9I1GrMNOHe/2WTcH6XAYNUjhM5USJH8BRF+qLzAn+6A/BAtf5
	 WAorb7VSFMHNvLVeeAtLpwdtx8WuZLF9SWEuIt4a8GYtalrnID9ynDnTeo/Q5Bo18ECBq
	 a7cLzT+5NPW7+MyD9CoChT9aGCkf11J1GC9JUBWfBI7fztEn8OxDQny//jlWIPRGWBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=NaMcmDrK;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA58D606A31C
	for <linux-modules@vger.kernel.org>; Thu, 26 Nov 2026 10:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA58D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=NaMcmDrK
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bba60271d7so14911125e9.2
        for <linux-modules@vger.kernel.org>; Thu, 26 Nov 2026 02:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795690499; x=1796295299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XCBi/ONXrkZ6TGvyvXiNuOf74OM2pCMUMGOrobsrG8k=;
        b=NaMcmDrKtdKUFey6abtW8FWJNaAGBaCwCWE/CoHQ0hU7cRs9OJSsKELdIyES0xUssE
         smyv143YfO/AKx8o1zhrGSCScIIOXlrgIV8RxO7Sfui3BXcxOnEK3DljqwcVoa7mfD2m
         6tGyFY2+vSschmOh3qlJfEUBemnI8dZ74nVXT9oIKMRjYne3K9JtAjGSmVTqmaq/N3SZ
         26T/2B1vpNJ78uWboCtBV9XcISV2wBISKBCK0CnLDAuNr4CkCPmc8UjLT3wPBkLcBlrl
         EDepqLXiifuBPf6klZhbJJTTvISmE5xEC361I5xqPzIAxekhfKn/DWjVjXvwFfBBHh9g
         /PhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795690499; x=1796295299;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XCBi/ONXrkZ6TGvyvXiNuOf74OM2pCMUMGOrobsrG8k=;
        b=LskZtXgA7d49q8xxskHWEb+sK4WJxfqwhtFfTOSY4LEzQ5XNzMMeyD2z+98D6a5Y2v
         Yx0cBqwaIfal9DbG8M4fsHXW/VsrX2mdi2kRFHq2uX+IU6tggdciWDscERyunQlHTljb
         JdDMn1EWokH5Kq8GfVVxFtCyxpoV3If76NH+juJQAWvtBzAGgMlJtISZvUmxVt3ZVZrl
         +NE4r68fmevfB8BLhd1E/ql86fiT+lz1GcMCC3tueiQKCaKtnWZraLp4TEKTQe6aiMV1
         x+FcAskxHPiUnf0lp3Au2rKCZn1bp3OaOnym6AzoffQ4CR57a4uOWOBD/+IHsExRo7k7
         5sQw==
X-Forwarded-Encrypted: i=1; AL+hErHw/hlamYaBfCZf26peP2tNnyFkDwlyQEZVP2cezZmuLDKCAHWABFf1xvfUKzuYhGqPIGclC2pT05hHO6vu@vger.kernel.org
X-Gm-Message-State: APuU4Z9xQBoNpxbgtiQjTKcGFrUP8bwyv8S5buA788hUqn/xyJjwViG7
	+SXvoUwKVPHbPRDjY9b54of1a5ZKPQl890y6ldvbQO9mQlDYIUvONuslYosCpV4y6m4=
X-Gm-Gg: AZFdTZfEOF43oGiL1uis7zaW4EEbtJUC4XWXhu+fE9xn56Kw9sp25wtmHCtQC47rAyw
	i24WzBKS0K5trGSY95tSqBssY34+EsflwBSTPxCKqPNiMtO40+R6rGWCWqOyExHxCFYj/+8J7gf
	Fe0D+YJqp5/pPFHQLx81Tjmuq/qH/HZYAQEp01K8AcpeACjkUt/L0kqV775Qe0kp4jrsyiH5rKV
	d0YMnkWinqdFd1jcIXKehNfX8kpKEjvyUJ0ZdQHv0pxlU0HYBlyyD12nEsAQU6Jv0OCnGmVZcD0
	NMGNQFsRLrPgW73tKqtXniqfcIFlIPbD1hIMBSLTnXKk9PMCt2SFLYAUyoQbzQ5w6YvFXovra/v
	aDgd7WtCQVW6iixFTJVhDNoB7sqIxspc4ykvmPR5rRcJz7cNI5OkStSIKCCjZz/ORr6LEqARRy9
	A3vvhH3S9ZxWnBonkNYfJj4/JLK4lN/kxpCLZv3t6uPAz58wBM40lGtQPsZOaP5qmP8FyJanwCQ
	+J7hkuL57QaFiY4WUFlOA0xH0ww0JUtHV9/mQqZIm64xV/YtJm/omrKT7rJb+4yCuqzKPYlBT2V
	EUk6xECiu6h7u4UetgtPgjs/dyy+mgDUtgBMhYVO4FXDhOUiIDf1ACcqRYtnCs7UaQ==
X-Received: by 2002:a05:600c:4e16:b0:4bb:69b2:d3df with SMTP id 5b1f17b1804b1-4bb88813024mr426154185e9.25.1795690499105;
        Thu, 26 Nov 2026 02:54:59 -0800 (PST)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm833925065e9.13.2026.11.26.02.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 02:54:58 -0800 (PST)
Message-ID: <b9a4ac5f-a71e-4538-aada-e7713e54b05d@suse.com>
Date: Thu, 26 Nov 2026 11:54:58 +0100
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module/kallsyms: Add missing const
To: Alejandro Colomar <alx@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-modules@vger.kernel.org
References: <20c798e8dd466896b3302b1de8b838b037d0b22d.1795629256.git.alx@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20c798e8dd466896b3302b1de8b838b037d0b22d.1795629256.git.alx@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/26 6:55 PM, Alejandro Colomar wrote:
> This pointer is derived from other const pointers.
> 
> Signed-off-by: Alejandro Colomar <alx@kernel.org>

Looks ok. I've queued the patch on modules-next.

-- 
Thanks,
Petr
