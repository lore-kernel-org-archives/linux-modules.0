Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE92226CF3
	for <linux-modules@vger.kernel.org>; Mon, 10 Mar 2025 11:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741604914; cv=none; b=uVfpqTYNP5IN7zxWKbN56r7hnlK0L/BaNTcAbjJncYSAadwmr8iSTXlpCOM3GN7n7KIrLToHPAfWEEP2OpdrvU3AWY32Mo4b4JCdIKYUejzqu7+P4i8eo9dUd99XpwyCzb904c01/YumlyBwTM8H0fdMLWd6fuxBuxwLGvVe4Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741604914; c=relaxed/simple;
	bh=2Fpr2s87toqjJkcGUKAHl60+P0Bejz42/H8P/L324/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r0F0WTJdw5dnaaRB8uOCfZxaGRqVOFh1bpaG3an0fgV7phb5LA/y/QmXhAhFJTDuurCmwyDMbL8XeoHI2TSeztqDIcTLtV7C9Pjwd7xHxyl6FscmSsZoItbzJMZJpUbtEzxXS3tyD8WyorUaAmQo8N+8g/1gh+v1CIugh0HxrYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YUntud5z; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YUntud5z"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43948021a45so34702785e9.1
        for <linux-modules@vger.kernel.org>; Mon, 10 Mar 2025 04:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741604911; x=1742209711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qj6OoGMan3+aUrpTlqHKjbVxQYo1LN6nRL8tRMEyjJo=;
        b=YUntud5zAu+Rp6uE/+1ueFvBdFDG+9gJ2rGB6yXRPOjeSBpWLgFB6fpjQsM+Hf3WNi
         eFQGn6lEMd1a6tl0J1DuzmNGnIfC8j5EjC7wv15iAVJMPkEZdeHx1Znx9LvSxeQrQzYG
         F1UTylS/TQEFuK/p+Avl/RuuvY0+ex1YtHLRpROHh41N3yNN9srrXADUWn93U3/0eEBr
         FHBzLhVx/zNomN7zRdPYQBnlcUGt0aSL3kAD+3ZIBZCXjLIzo/7ywjCIx+SdAFyTvd8W
         yIvjt9vMS8WrJcQtEOyjyXsh0E0elp9gAsB8Yl6tCboNCfAi+dTDviCK+BP7a0208UyN
         ypmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741604911; x=1742209711;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qj6OoGMan3+aUrpTlqHKjbVxQYo1LN6nRL8tRMEyjJo=;
        b=puCtIDAEbftFtWwwLpAUsPkljM82r+YwmVZEPxUgAZGBUtanRzzzMXUc4gOWy0fe1S
         QTgdVzrSnQGMUEnGYfoqao+YhUHK91cpnlh7JVEqiUo34KlAtkXVtbrGXEy7tZQwOBJO
         6JF8T20nubZNqHuMvTdg/++7vKVQGLWczmOlDIzuqB/OBoz9ikZN7xiTIz34/ZMe1fPg
         mNOql/+vPYBnGz1Jq/RUDq1789l9BrZTzV5RPmzrC4cET2+2bt3eY0OxG9++Y2l0NVvV
         NlJmoyCRk2LaSz9zzad970NHMeSsaYFpxqsvQKM63Xhe+l7t6SaJcFB0TGfarLywDxo0
         CnOg==
X-Forwarded-Encrypted: i=1; AJvYcCV5eEPukd0BEAt5XGohIcrgZ7GO1Jva3rD8UuWYKjjkojPTWkOCW3CHqXDHgUmbBNytZ4adavJJ1HSBtgbh@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1jlPIW4l1Dfqf4SgFjaUzpBEfTpHw6WPCnzxCP0bUbdObuvkL
	lIsNoBDDtnZbaBbK4w/k63oSYXVxjdjAq/Jrw2rSmbaWonRtlsifCL0Qi1C3fbA=
X-Gm-Gg: ASbGncsKXMk6b3R/b2lhKpxkAX3wb53X7xjWEwkMAmB+gwyYekpLU1acQo/pb6Ebs5n
	exNM38pxK0dbldJikJawA5gm3oSpdb5qQxY0cwxswSefoJ0kZOHyxEbxAZPZ3b1mWlsKDrnKpl0
	MMthbEvKa8Yrzgqcx8qAatpIIr7+MO1cGQZ5D1YcxfLULtaAFSY8bokE73t8vrA4C8Ea/apZ5dJ
	Fi+UK/GPM2eE9WsLwkP7doeSI8v97lMhhDanmGC5y61vYMlSOjTAIF7ENhWey56HXYaAXiq/bLP
	A7yQ2aKZ/yB439+XfP5YtsjFxD2ln1oIU+ZMzDmntoU/zaS/
X-Google-Smtp-Source: AGHT+IFUTAvlUQocnZuhWGDfsKJ3140vKmzfp6gwINFwcRcFXRbdY+k2lSsw1FVLxDt2VmJcsMNhJQ==
X-Received: by 2002:a05:600c:35d3:b0:43c:f1cd:3d78 with SMTP id 5b1f17b1804b1-43cf1cd3ecbmr26249125e9.12.1741604910988;
        Mon, 10 Mar 2025 04:08:30 -0700 (PDT)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8b0425sm141811095e9.3.2025.03.10.04.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 04:08:30 -0700 (PDT)
Message-ID: <5d21bf87-37c6-406f-8705-82968ba0e8df@suse.com>
Date: Mon, 10 Mar 2025 12:08:29 +0100
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module: Remove unnecessary size argument when calling
 strscpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250308194631.191670-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250308194631.191670-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/8/25 20:46, Thorsten Blum wrote:
> The size parameter is optional and strscpy() automatically determines
> the length of the destination buffer using sizeof() if the argument is
> omitted. This makes the explicit sizeof() unnecessary. Remove it to
> shorten and simplify the code.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Looks good to me. I've queued it on modules-next.

-- 
Thanks,
Petr
