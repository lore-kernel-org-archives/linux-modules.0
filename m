Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A622B3B8921;
	Mon, 27 Apr 2026 11:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777289344; cv=none; b=CfIBCVcMdn7R6XQX6ThOjv8wYpxrzak37J2P/LXtT4+iYBp8u+lBn3cOaxq3Ql5Irtryr6ZQ32ZCLiqNQ6H3HyYaozL8D93ynZa5yYrY0cVHEoRja7IJWELhAanNHgV4QiwWMPv4KHhQswBNWZrzXhy/HiDPjxpo01/vv8Ygdw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777289344; c=relaxed/simple;
	bh=70r7fSEnH0CEsVRa27rLWqlD7lAp7l0plvtFvK+ONyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fqfDDmpqrD/yGANnT/MdpldZpdcOrhriFjhe8F53qdyvukNqOcfzFGefvVaoxUgbdGa97PdIXQm/vMzOZB4NWrwST19F96z5cJ81OxkkTHRkTIHFIaGCwzelS4/MLBiuwUN9u4XF/02MLPzG0cSC0SofayW1+tkTNnlpIcZMwmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hj3hDcte; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hj3hDcte"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5405C19425;
	Mon, 27 Apr 2026 11:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777289344;
	bh=70r7fSEnH0CEsVRa27rLWqlD7lAp7l0plvtFvK+ONyY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Hj3hDcteVdta+yCjx7SEyhoGBg9EWWTm5YRyle7G3FHxrn/uhgnTGxjKr4r/MjJyM
	 TU+X+Y+IrZCvZ0a/6O4w2BUQZYWa6dFPWVNF8FZYr/FUsYxRXQ3RwUqBMtyKw1IkTY
	 yp5jL3peAO92yA/6eTWpJkqaOqEoXNq5yt4nCjEoK17oyfVc8K36CHqhp3hZC7WaCy
	 FqAqBvWexs2Zg3lYMd6S2tlTkNL05p807ywr/M3Q2xXbUoiC3CYSr1hJGbRhmX6PQX
	 pp08asOfTDST0CRmY8gAPdIQC6oyLEmMw4aQbGA+pKD7rjFg28F4iVu5npzitpSkt2
	 BIy+qKDUCx6hw==
Message-ID: <b5b5d2de-2be7-4bcf-b4f4-1dda6b09130a@kernel.org>
Date: Mon, 27 Apr 2026 13:28:57 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: module_param: use `pr_warn_once!` for null pointer
 warning
To: Andreas Hindborg <a.hindborg@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20260427-params-pr-once-v1-1-3a8c64704cc4@kernel.org>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
In-Reply-To: <20260427-params-pr-once-v1-1-3a8c64704cc4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/04/2026 10.11, Andreas Hindborg wrote:
> Replace `pr_warn!` and the accompanying TODO with `pr_warn_once!`, now that
> the macro is available.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Available since v7.0-rc1. LGTM,

Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
