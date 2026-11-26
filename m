Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795689925;
	b=1MoIb5UyWy8S53+cvSxLg/rKhidb1APhqMTjAsJU24+wwRA38CZBYXtn3i3PMYkrBcW5
	 1yXW/s+5aoEikPr93FNrqYlw4CvdOXpJ4j67FOwd0JIsI2ZL8KtQ2dVa3EMi6KFye1zd+
	 DAoE0AG5Jt0e2TSacf0Sa4q/7zuqZfniOk7c3ZLVw+y9FIcguVakp/vpVKvSvzDoLXfU1
	 3YiXY/54fnZuwRZDFitXDyWrC1quABc1ybFFhxtbqHAUp1vgULZkO3AYICkqG6bhcjr/g
	 7slgZhoCWG4TmrcwS026nWoz6M2BanFdZyopKvIcGrSJh6jHwNsP9ar577s6Q6NuS0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795689925;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Un6gMhy72C5GdMKpxarLNGYbqAQ9rBfW8csPHV3xsTs=;
	b=n0OaUGfUdhATWXTRcj8mxpukqgxTxLA5UnOPOSIpm3e+A6rNNQERPMrCsHbij0t9TIgc
	 Uyu6b6VBTiPmQO4mt/zUCb4URsehWUOocW4RFUVLFX/jyb24QOLryWM8h1n8qQixg+Z2v
	 xk+T4GfQL0cqAAOsfxNdj7tkh+iRd8OTW2FAe4LOaHcR8yG/zyx52jNSwy6kCL8Fiez7o
	 wZZjlRZdosuA6dehTWg7xwemwsBE3Ixj9zoQpBf0iRtXN6YUlFyFYvz9pmNDsbmC32XL3
	 4HrnFjPJqor1spvYQ/u+9+sUhfRUbPgglioQk96qiwEv/rL55+Q3LTS33RCt3bKPK0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b="fb/AnGuu";
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F90606A31E
	for <linux-modules@vger.kernel.org>; Thu, 26 Nov 2026 10:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7F90606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=fb/AnGuu
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e09aa5264so3982787f8f.2
        for <linux-modules@vger.kernel.org>; Thu, 26 Nov 2026 02:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795689923; x=1796294723; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Un6gMhy72C5GdMKpxarLNGYbqAQ9rBfW8csPHV3xsTs=;
        b=fb/AnGuufRVSuumZI6EQLA6cj75+M3xYaDzd0Gy6RIfFD9vTufZ0ocvqMKbKkCMuJU
         HCBXLOxx8vgikybvFGaP8kOTEPC96KRwXnjjGdmpRLIAP3v7/cEX49ZmqXzavqZRuij3
         yAgWXhNLnFWVkhqNg9FhZPzLqKHj3vih4TQBrzWrYFpbfSQ4U8bI/qVviCwdNFG1GKRg
         Hxn6CMjZT5DpBlzV5e6WnYlgdhQXs2yNA/UJVS7jWkPiOHnO8ZNEWlUFaREDrgmI9OpC
         SZzobCPy89LxilfHUkDRa5QJboD//JYUx9AJLoSKPUrVgXCRpyowQ5xPdH3/qHs9I8jV
         3Rpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795689923; x=1796294723;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Un6gMhy72C5GdMKpxarLNGYbqAQ9rBfW8csPHV3xsTs=;
        b=GhSoNd6VSJatWE1YjugGZjVr9cySEzYLpV8r19MHXA+9Wv7eQrHsNDM1RphqHw0h5J
         wC3cslHtHp4/zAs2z2uXbyq/HkOwNXM/DNxe87JsFH75NyAYoTEVrXw7gJVjdrJ0503K
         wJf/FgXvFFgL11vZzCDf463P271jzr9qS+x4t4HJMhjMPKSpDyAyKcHNnGF2ubGbzGfF
         ioRB94BubtFBvb41YkWDJcw0Fllp40VhmSGUQiMSEmvcHKzd9Xta9x5lQtdaYSrBQo08
         x2FZzzxAJR3ARet1WhGOJEyiCygOuwtTq5fLvP45yV/AsOPS7JcLaA1CyGvPkq/zG9c6
         I6Gg==
X-Forwarded-Encrypted: i=1; AL+hErF1H26B4b8ACOTx3zuJqFWDzkV4zpk8wUfNRteMhNHrOnPmlcJ3lJpm8TULuYv0QUfmlys6lpXMWoRzvahz@vger.kernel.org
X-Gm-Message-State: APuU4Z9+4+AThsPVRemEIUMZ7+6eBLweKx1nN8ULLbo9bDpz692+5mta
	rbI6dBRSr5PMVYY+E3Rz0Pn1Q+wYREnwEkmdpBhUoeI8U5BYaLnOSkFqjNZYZLkegH4=
X-Gm-Gg: AZFdTZcVGZk3woUByoCY7VNtzXMKKAxhRVTFuMO+1iM9FXHJ1BaACgoCfsjfjsBl/zC
	gvBX5iSS5Y87tLLUfIbxL8ji0/50V1natGkpFaCvqOHPA3PIXx7OXdD3VO/XTOrVSiYVqa1DobS
	WWb4Bd00L05ctPoJtVVzXydIAEhZfgrUFY54toKNBEDbXW7zmrXgMcZvau0akh5Wu/KyguIUszl
	+7cvPNWMszPrz+lqXOWEZGRGFlgtYlxcUGoItaeA7S4ywDQRwS/8/XuRH2ci8wg1v9YDoduypkh
	+xVv0ey/BrqOn5t+UhcLKJIXxtBqSKrHJOwDT6BAIAkdiSBWBNR79brsaUpZhBC/gmjQXWEjGCv
	UHLAECJ9uDFEUiJ+HzKAb1SxmADh0J1dwHYaB99vdZC6sTH6ZAy550y8wZtRjWU5aPR2N7L6vp0
	5FMAe08vTUtSVOyGLJTsDKeZoTqpXqoqQFovfgc2O6LBx3IocmyX0TWd6L/DDYSauPsvSdRJiJz
	wuKOX1ofgdtfT9x5LbqOXe+aTIK6rggMpj/SgCrrr4s3IXMQ//JbGbc38WBWnnGHlHYytu5vu3A
	i+ZsLoTi3up60URN/9Kjkelmyh0jZDT9Fc9Uu+WvHcb1E6oLnPYi285hp9Q9oBNt2w==
X-Received: by 2002:a05:6000:248a:b0:487:b50:101c with SMTP id ffacd0b85a97d-4abaa97702bmr38359967f8f.5.1795689923186;
        Thu, 26 Nov 2026 02:45:23 -0800 (PST)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bb98b4dsm40416103f8f.53.2026.11.26.02.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 02:45:22 -0800 (PST)
Message-ID: <a40ad738-cb7b-469e-b67b-353b64622dbd@suse.com>
Date: Thu, 26 Nov 2026 11:45:21 +0100
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
Subject: Re: [PATCH bpf-next v3 3/9] kallsyms: Add KALLSYMS_QUERY_BY_NAME
 ioctl to /proc/kallsyms
To: Samuel Wu <wusamuel@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
 David Laight <david.laight.linux@gmail.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-modules@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
References: <20261113221248.3535369-11-wusamuel@google.com>
 <20261113221248.3535369-14-wusamuel@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20261113221248.3535369-14-wusamuel@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/26 11:12 PM, Samuel Wu wrote:
> To find a few kernel symbols, users such as libbpf parse all of
> /proc/kallsyms, which is several MB and text based.
> 
> Add the KALLSYMS_QUERY_BY_NAME ioctl. It finds a symbol by exact name or
> by prefix in the entries of /proc/kallsyms, with vmlinux matches first,
> and optionally in a single module with module_filter, or all modules by
> default. Each call returns one match and its position; pos + 1 continues
> the search, until -ENOENT. The output returns the address, the size, and
> optional name and module buffers. A buffer that is too small gives
> -ENAMETOOLONG and the required size.

The kallsyms data in the kernel can change between two
KALLSYMS_QUERY_BY_NAME calls, for instance, when a new module is loaded.
Should the mechanism provide a way to detect such changes, likely by
tracking and exposing some kind of generation number, or is it
unnecessary?

-- 
Thanks,
Petr
