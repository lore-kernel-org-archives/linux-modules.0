Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE8828A1E3
	for <linux-modules@vger.kernel.org>; Wed,  4 Jun 2025 08:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749027056; cv=none; b=QUqn944vy0bQLx1fXHYh3rsuW5HYNOPg8ZLsdcFeN+Ro/vBq2Tl2CTs1HuvA96eysksh4PAN7H56vsLVV25Bi7sKe8vnwajJaIAf3sOpfSmFAgypdWboG6Jx6E0pAbOSJepqXqqLAz9zyO/kr3E8tqgW40d1TjGOrHWNMSszP6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749027056; c=relaxed/simple;
	bh=Ucyb7HM9q3iBWoY+J0DTOECfsiFV+K/mKL1I+Hi+Bh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQD5QsfmGqhXndPbHmfczKP80JNDm6lgBzgpR98LpbxPRW1STlAsEZHxXu+2C8pUtG7LtHzOAUKEGaPB7JaXSOuJxu0l4EXfd8GQz7+eAYtCz0BBiGfG2wN7IfOHq21xflS237DffsFV8Quffl56cucA6btoPzvOMViQ2T/oWbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AMvrb7aL; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AMvrb7aL"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-451d7b50815so26909545e9.2
        for <linux-modules@vger.kernel.org>; Wed, 04 Jun 2025 01:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749027052; x=1749631852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3foMmPCBN/XslK94eXO9+AImwpoVgcIU0XR1j/KP7x8=;
        b=AMvrb7aLhr8rg2AFi+oXRe1iGMWyP2DFL8Qv1pYWjuBjsHrOule9bjoruvcJXS4Kb5
         CjEHjH4V0fPdDoWYnefW/lxpim6R3WlxLcitdgecwnbbMnS3pROFFtl6ZCwRWj2lqAHx
         TqMCgJK2ncvk8X78YFKQvKWR4kh/w2uoZ3uWeTPANAV5j1WEsj6lFdHbe//j5UjT61SQ
         HOnuRgVXAxhRwYFelK6TBb+oiQKHg/s/MGUFbd91cmPcJYhH7tahSz56ESJmFJl/7y3Q
         TftnrQ9nvZLnhsoX03V6icGdnphNlAeAkV/1DhnPR2nkjf1Gl7UrtyxlE+4ticjCpfOS
         9AvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749027052; x=1749631852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3foMmPCBN/XslK94eXO9+AImwpoVgcIU0XR1j/KP7x8=;
        b=DUeAsIOH7tu0RDoL0A2iXhK39nb2edj3K1hDCEpv9yvoixS75zUHygICmuBilYJX1X
         1E80MOYhRNIZOD9PLXmS5BOiZDMSJEqzhe5aLJd4X9ZFH/zmMW2P5hnUwSh7jx0F9u4B
         HKz2sYQWfcy9XHpJJhUJFGwmcx9fV9f0BUbfUmLS5P0XsaUvNqjK1Txl4jxtq5nWsRWW
         1JWjOjidgjlXbkAik4Zui7mDz15gwLLQBl/bLy5x1mrYzNQvaOsdXcAHTNeaJ/wj4WdE
         i4L+PIRywFOmnHn9dYicW2W+S73I1yzmOjykN0hVNLBiCfTRZ/5B51a4bCaEko98adBv
         /cWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiD72/eSQZ7ck6vH1xvpu6n4DHSTc45jRtl5Ap7dG2ucnkOGY2quLRw91aF+XLfOyfJwJdavO/GjKaIchd@vger.kernel.org
X-Gm-Message-State: AOJu0YyAV/012qCik5rnxNSZC04kCpvzjLt/i4Or8p2PlHNp8RYjK5js
	w0v093oIPhpVbRqke7HDBGopqzqYxoNQJ8q492+TqJADQd05I480C0ztszpOwqGDcuk=
X-Gm-Gg: ASbGncsuS1wyrzZ3xmp7TC30YEMMVEm0NotcU/VHlhD5zhiO8RBM711F8RX+Y0rEX+E
	vCqlDw/ncs4f7ca+ueuBdBNjmjcAZ3V/nHyDXp9MEWMCsCf2HPOKpBJYBSL8+t0PULBZaBk4TPo
	jomk7FHoTgT0IkY5xNRW/18utTY6M2T+Rqb8PuX9EFi7vHHvCNRTOdA2Kt53cQlh42XvabA28AC
	zSLTDgYtm1usVTuHxUPaakOXjK0dvLIBV3PDKACK7iBlK0P7qD/SpunGdimRB39Nb+EenisFu75
	mMcVspUgKsJ9N7tr98+Lqs4sN6sXGRn5sTMb+3JtW4V78C0jfgY7Q0Z6NqOY0fkndwc7xw==
X-Google-Smtp-Source: AGHT+IGXuIW66YuEANUhSYmsO07+uY8r6rrbyfLLgRS1ue2JXGNF53sbcRUniQkWcRX66Kf/R9mD8Q==
X-Received: by 2002:a05:600c:3acf:b0:442:d9fb:d9f1 with SMTP id 5b1f17b1804b1-451f0a6b1e0mr15804905e9.4.1749027051914;
        Wed, 04 Jun 2025 01:50:51 -0700 (PDT)
Received: from [10.0.1.22] (109-81-1-248.rct.o2.cz. [109.81.1.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5233b0723sm311469f8f.86.2025.06.04.01.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 01:50:51 -0700 (PDT)
Message-ID: <4fefa5cb-462f-4e13-9d45-f58775d78bab@suse.com>
Date: Wed, 4 Jun 2025 10:50:51 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: make __mod_device_table__* symbols static
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Gomez <da.gomez@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, linux-modules@vger.kernel.org
References: <20250602105539.392362-1-masahiroy@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250602105539.392362-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/25 12:55 PM, Masahiro Yamada wrote:
> The __mod_device_table__* symbols are only parsed by modpost to generate
> MODULE_ALIAS() entries from MODULE_DEVICE_TABLE().
> 
> Therefore, these symbols do not need to be globally visible, or globally
> unique.
> 
> If they are in the global scope, we would worry about the symbol
> uniqueness, but modpost is fine with parsing multiple symbols with the
> same name.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
