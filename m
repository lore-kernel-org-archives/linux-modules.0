Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YI7/Kak+"
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739B09D
	for <linux-modules@vger.kernel.org>; Fri,  1 Dec 2023 09:43:38 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6cdfee14c24so828692b3a.2
        for <linux-modules@vger.kernel.org>; Fri, 01 Dec 2023 09:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701452618; x=1702057418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owVCh6YYqr7z4S5sGKUp6ONDt91jAW/AQRpQ3Hht2rE=;
        b=YI7/Kak+M0keC5LYFWRieAtFQwy88AELhJqtqjF8I5j+6QrHbQpLMUnvFnZKVQV6lp
         3ZUbVgw4uMqpEMhQ8ckfpqiQGK8GiarJOHOey9exg//I7YW5GUJJTLcnpt/6+nL7CiqB
         Dmi5ArKy3TJFVeZkMM+4Rls/a701Y4Q8E1kHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701452618; x=1702057418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owVCh6YYqr7z4S5sGKUp6ONDt91jAW/AQRpQ3Hht2rE=;
        b=mTzLEbKbfJtOdqZMO75YOmmXnJ44EFmefs7KwhFG2gSfV5yOA/VdwnYOAdzCs3HQ6I
         ZnA1PdUX2pq1R7znVPgyWbC1VxeSifaUYpbaKwBMMy6gvWL3bnWShAg3aCoH0ESW0qUH
         PdZXORKkZ5Kwh2NHszqtTMbvnXKmeK/i2/VFLCW7r0/IKgQIkTgycE0p59rHu/oG0LI7
         6IyEv5hF499GRslFO5fIGPTC7/QHgt8807vm51KbrHJM/CaI/T/cZet/eBqOeE/h1Kkx
         uVEE2f8lFu9tcwNLLwqXAXSLFFXvmTPnkqHbn8xHkUs8xL9TpHSX/ZWVtJJkUgDi/V1t
         QHvA==
X-Gm-Message-State: AOJu0YylpxeyGBmPs5mzx0BvaNcodvUJqsyB9hHLspiypKsELdfY+Iqo
	OfHCYWIZFl3AmrLvbaIF90d3uA==
X-Google-Smtp-Source: AGHT+IGOuYgE89zGxitBsGpS1stcNDAWH4UYrJxRMm1q2nWCOET/iHUVMET1zt+ZzAFlo3U8nzhDkQ==
X-Received: by 2002:a05:6a00:8d87:b0:6cd:e65f:f6c9 with SMTP id im7-20020a056a008d8700b006cde65ff6c9mr6448864pfb.2.1701452617964;
        Fri, 01 Dec 2023 09:43:37 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n23-20020a056a000d5700b006cdd406e784sm3262884pfv.136.2023.12.01.09.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 09:43:37 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Luis Chamberlain <mcgrof@kernel.org>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Kees Cook <keescook@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 0/5] params: harden string ops and allocatio ops
Date: Fri,  1 Dec 2023 09:43:34 -0800
Message-Id: <170145261350.53238.3359968215284616685.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120151419.1661807-1-andriy.shevchenko@linux.intel.com>
References: <20231120151419.1661807-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 20 Nov 2023 17:11:41 +0200, Andy Shevchenko wrote:
> A couple of patches are for get the string ops, used in the module,
> slightly harden. On top a few cleanups.
> 
> Since the main part is rather hardening, I think the Kees' tree is
> the best fit for the series. It also possible to route via Greg's
> sysfs (driver core?), but I'm open for another option(s).
> 
> [...]

Applied to for-next/hardening, thanks!

[1/5] params: Introduce the param_unknown_fn type
      https://git.kernel.org/kees/c/aa61d651412a
[2/5] params: Do not go over the limit when getting the string length
      https://git.kernel.org/kees/c/e6c5b15619a2
[3/5] params: Use size_add() for kmalloc()
      https://git.kernel.org/kees/c/9a4a4b528bff
[4/5] params: Sort headers
      https://git.kernel.org/kees/c/18bdb5a032e8
[5/5] params: Fix multi-line comment style
      https://git.kernel.org/kees/c/c62c9771b7d6

Take care,

-- 
Kees Cook

