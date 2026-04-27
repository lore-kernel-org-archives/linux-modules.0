Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A63025F99F;
	Mon, 27 Apr 2026 08:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777277089; cv=none; b=D7JytI8LvOxwspjERfjMSZ6EuqLaQFg5HR4zP7c2tDhUsN1nOD7+TPEkbDLzRoERzsTkbqWikUoopstBdSiAOQlE3MASXU0DQP5HbfDf81flNt0ryLq2KcLK+HwJpcyPrQkc0948q4llTiE9IQWWfNJrnt0WUIdktmjMPbKpoCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777277089; c=relaxed/simple;
	bh=a3KsCsQY1qf3Eqj+ww908F1BuBkQT/7TSswL16BGEr0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BMWAMDa+USFqz5SiJD4F9oHlmBCuBmJ5fwYlITdN4pFApbFMcTtPTcJGQ0sbKJSL5r/mQaszGGUVy2DH28BwGHaRgkXQUoNuXMXUVBvGK8Kj/wtISLsqQHrJuPwHII1oTBpQFJ5xq3Fy2zO3jiQTxNLb6Hp/D86Xcx1lv8ApJF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aw0958X3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aw0958X3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49BFC19425;
	Mon, 27 Apr 2026 08:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777277089;
	bh=a3KsCsQY1qf3Eqj+ww908F1BuBkQT/7TSswL16BGEr0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Aw0958X3R5h6nswE7Jjc9xZ24VT0QMvEnhM57z6sIHKkbXFQDqUeuq70R3LRXK0oT
	 L3M8UJbAoy/INYEhhWViPJHKB7E3tJj3GocvNNTGsj9ex6ZBHZUnL8A0OBPVDy22Hf
	 yebmRcDCQT1hLH9loMvqVaydioydhyhUg7tbPk76YyJX7dHihSa9647EKDa4Ry3KKO
	 GPRXgVq0zI5u/5cwKphKFBANdYSJjFzASri2cTjptsjlVBBsz6XMr3NIOP2O5Ikoj7
	 x8iUhTyTgF7AcGkZC8y/5LA3GYOc6O48AQa6Xnl7X9ZzsWuAGvogiGdbYsF6pYp5bP
	 YEOGKjT0lxULg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>, mcgrof@kernel.org,
 petr.pavlu@suse.com, da.gomez@kernel.org, samitolvanen@google.com,
 ojeda@kernel.org, linux-modules@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Cc: atomlin@atomlin.com, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, dakr@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] rust: module_param: support bool parameters
In-Reply-To: <20260411130254.3510128-2-wenzhaoliao@ruc.edu.cn>
References: <20260411130254.3510128-1-wenzhaoliao@ruc.edu.cn>
 <20260411130254.3510128-2-wenzhaoliao@ruc.edu.cn>
Date: Mon, 27 Apr 2026 10:04:36 +0200
Message-ID: <87tsswrfqj.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Wenzhao Liao <wenzhaoliao@ruc.edu.cn> writes:

> Add support for parsing boolean module parameters in the Rust
> module! macro.
>
> Currently, only integer types are supported by the `module_param!`
> macros. This patch implements the `ModuleParam` trait for `bool`
> by delegating the string parsing to the existing C implementation
> via `kstrtobool_bytes()`. It also wires up `PARAM_OPS_BOOL` so that
> the Rust parameter system correctly links to the C `param_ops_bool`
> structure.
>
> For demonstration and verification, a boolean parameter is added
> to `samples/rust/rust_minimal.rs`.
>
> Assisted-by: Codex:GPT-5
> Signed-off-by: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>

Looks good to me!

Tested-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>

Best regards,
Andreas Hindborg


