Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242593;
	b=ak27ZEl2ByKcyfHzSSh3gX8T27yI2UtX+cjLNOgjqd/VUv539uQH7ZGEb/QRPCpAxl2V
	 utQjz7+Zk4knxZ9e/sZQE3zLBZOk+sI8RNx5RQNa5aRNED1m9BtFtQzy5avvFJS4WaFCy
	 8fXaWbCTRaTOwRoI6J2JTmMD4Q1iUBmvf3NA9MlAYFiILXfbsz9x3RtXi7mBMWpPOqKpY
	 7Mj4lkK0leHNleMYnn5nPB4C7AlV0+9zac0wLvA6NNz1fAarqKGqJJfGrReANtgpYqHAR
	 GVZZhxbxRgJxSWaWpFzBcBEC9mU4aJrHj/GFcIMm+f2a38+ZeyayALN30+4hGBeFylw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242593;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=HLYen38mKGP677B1oAzbJm7ZesXCZSDjKVwDLOHWtRg=;
	b=3+5yoEAOrSlohdtb0n68pdSGGX/Blw3gWUzeB4FBZv7NPweGWQD8w2iU6tQ160JcgY2M
	 DuKLy8+AwMs5nsJE06CKjjzWSySaotD1wlq75+C/fAoUu6ot845j0FnBDBvhOvz4fLos4
	 WDzXQCO+G//+xgzgXmrjzPPXQylUSUq47I2XMfbh+uoiFXMBcdXI+hbqg6dVku12Jwwvv
	 oGFkt0SwIuFnvqyQHexDNwTm8dibxFvVlNCMbdN1RHnupUkEClwvRl0P56glxxM6M5sNA
	 aveUg28J+IAuwZ1OafOimtpffD5FY05zAcet0X5YCUPq93ho1W5q/WCngjSggE71d3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=YGuhw1oZ;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3CE606A334
	for <linux-modules@vger.kernel.org>; Mon,  9 Nov 2026 16:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD3CE606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=YGuhw1oZ
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so10764165e9.0
        for <linux-modules@vger.kernel.org>; Mon, 09 Nov 2026 08:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794242591; x=1794847391; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HLYen38mKGP677B1oAzbJm7ZesXCZSDjKVwDLOHWtRg=;
        b=YGuhw1oZxUPL/bbx+i0ijosSnISYIbUul/qGq2zAELOacB08dvYDccSx/x9rU6g9gl
         QyPht0zwbkvD9ejc3WNj6TDVij9KZUrBEQ9Xt5i0q2PMick2I5G7BiPPIhuJ5QsC5cpF
         Hc9VdS41J2qakEC5kRjP6W1h9qpqNpRyQS76N9UiluO+WrKbrxUc+eHpH3MgwEVU/LBg
         EKYTjvlmvVcRDnUT5YdBxwyzf6msDAIK2mLzEprKTk57LkQxxSPMwQJzYJo0fRMdPBCc
         S1EcyuYCyB06Nre1/tH9qJ9dfWqNPjCBc4QnRUd5kWvI+126KhchYL1WWv8hq+Sx8TwT
         sacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794242591; x=1794847391;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HLYen38mKGP677B1oAzbJm7ZesXCZSDjKVwDLOHWtRg=;
        b=bywSabv7zmUxfTCSAk336QFptUw7ACHGD7+yroNbADv3Rbb/aKrj/DZbHsacebetBi
         SCa/Vdyz6QqpDvHhfSNtq7whI5TA2Y9VZ8fbNSJS7UqcWLhZSKaPqIgzncO4ERKDXTLa
         WLdW3xwI3pphrg/dM9D4ckofy3rYqhhI8kxQ5v5Rd4jljCyl//aq+s67u77zuwRL9JVj
         pSfdyI9nNfRqyloYf25KB8XNT0WrafrL8tc2dpdMOKuQdFIPbRKRm2cTNe+ft+w0Fona
         BIsRvBO8asDKcXgApxGMDl/zbC26UI/0yfYnCi+kXgB3H4NGTbuspmDGe3VyE+NSx0du
         oImg==
X-Forwarded-Encrypted: i=1; AL+hErGkPBGsZJ0GJixBYM0PIGccoF6S+u87vS2ESaXY/iivw0eoTUORQQty2qk1dazJyj0YKUBb/C6+UFHiNNlW@vger.kernel.org
X-Gm-Message-State: APuU4Z/SSVQLT8V8IQWpBsLjQ03tO2JA56bb7RstLnH5JtZamztacc1l
	rxZpi9plesN0OoytHIi8jCy/MsHwTesGnup6wgY+B1oIBIeET133l+o/100KJ8FAO80=
X-Gm-Gg: AYBFou3aFB4jA3K2FsiTuEDY9NpdIgGGFlxGQt5zrGrWmCFjJ7crOCUqVMoNkcCw6/2
	Be7RQSFeuhMKf9FejTeLE6dG2/gZcTQN065wrIDJH4Jiavib5twqYSwCvCw3MnwkRj+E/1FhrLy
	oD5LgPzozqXgjPiiu52Qa0TIazV2vF1Z9InegaFO10e/apihKDVVyK8KRE8yTf68RuDCU24vP7K
	jiu56nf+Qvb66Cdg2NYq3aI/uvl41OBQNYinZYq4UsM3K5BNMRzbjg7PsMX3fLWUnYKFuCrwQ4H
	97r19hOGmfZPuK0GJsemRwVlQHcZkDszCw7WjNjLT4/kTHUX7R/BvHy44G98guy+lkWaZVFeSVV
	Llys9F8+uSWIkPVqW/alxplumOF9vK5UhOINhyTGInhs/GkAyRwFUB4KNC3e+iGwDV9Si74gtSF
	S92bFtkxTUy6das0sJC5OqAd/8ZWRl96H9ZFt7SFCwIrrqDM0GZVt4avjxc2tiq0Zr7Nj45IlfZ
	HNaCXpLvTSECbdWAx1nSivaZmIkXy2R1qkq2M7f183wtol3Z9ddIFzwV5iT11d/BDVCbN3Fstru
	F1ywVmPuF0VasLujwEKQYKcb2SLOJBzb8pyE4jNrltbQC9JPWCRI4CkE9HIas6Zz
X-Received: by 2002:a05:600c:3508:b0:4a2:526b:d40f with SMTP id 5b1f17b1804b1-4ba015b8c6amr1961265e9.0.1794242591012;
        Mon, 09 Nov 2026 08:43:11 -0800 (PST)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01d8ae9fsm806785e9.3.2026.11.09.08.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 08:43:10 -0800 (PST)
Message-ID: <1dddcf29-36a9-4ffd-999f-54b730c9ea27@suse.com>
Date: Mon, 9 Nov 2026 17:43:09 +0100
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
Subject: Re: [PATCH v5 03/11] modpost: cache section relocation mismatch state
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20261104-build-speedup-v5-0-0f6018be8dae@kernel.org>
 <20261104-build-speedup-v5-3-0f6018be8dae@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20261104-build-speedup-v5-3-0f6018be8dae@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 7:20 PM, Lorenzo Stoakes (ARM) wrote:
> For every relocation modpost invokes check_section_mismatch() to determine
> whether there is any kind of mismatch between the source and destination,
> and if so which classification applies.
> 
> Each time it does this it invokes section_mismatch() which iterates
> through the sectioncheck[] array every time it's called.
> 
> When walked a relocation section the source is fixed and there aren't many
> targets, so the same names are looked up over and over again.
> 
> Therefore cache not only mismatch categorisation but also whether a
> mismatch even exists for a given section and look up the sections in the
> cache.
> 
> Special indices (undefined, absolute, common) take the uncached path as
> before.
> 
> This results in very significant speed ups for allmodconfig incremental
> builds.
> 
> modpost is on the serial tail of every build that links vmlinux.
> 
> Whole build, 128-thread Threadripper 9980X, best of N runs:
> 
>                                          before   after     delta
>                                          -------------------------------
>   x86 defconfig, touch mm/vma.c, gcc        8.5s     8.3s    -0.14s (-2%)
>   x86 defconfig, touch mm/vma.c, clang      7.7s     7.6s    -0.13s (-2%)
>   x86 allmodconfig, touch mm/vma.c, gcc    33.9s    29.4s     -4.5s (-13%)
>   x86 allmodconfig, touch mm/vma.c, clang  31.9s    27.9s     -4.0s (-13%)
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Looks reasonable to me.

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
