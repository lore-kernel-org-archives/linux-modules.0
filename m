Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6039C2D3A69;
	Mon, 13 Apr 2026 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776081630; cv=none; b=jl9DN8xkbTQB+E4mOxkATcGhsoeSGtJSo0Me447KuMlB2rk1XoPnZ2bAOkZwnNtLlZFIjRmF7uWXVkqcYqIju0F1iuALXCnX315dfXtdIr+JTnBoMoaGmeztYIMrpRXaIvT7fmE1uxiOS+0P5pTUTYIdhB58AWpklGbOcyhNl4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776081630; c=relaxed/simple;
	bh=/SQ/HJMfIm57NSsYp4N6l3WTbv/0BrS76nAygALm8hY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hZuitb5NM/esRvf0EfhldjEgeGsAPPWRYYhwiwojxbt68uNyxK/TKVcJlIS4nGLMY9L+1BPGqED7aUEegF6hmLoWNsBfUqXY9+mDvLrqgRPkuPcFRDZBniw0vg+tpHXz6wGpAUuGNA70JaKxhMnZH8+Qob+Iw8YuqxOvnTVrnuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csc1a39I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csc1a39I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBF3C19421;
	Mon, 13 Apr 2026 12:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776081630;
	bh=/SQ/HJMfIm57NSsYp4N6l3WTbv/0BrS76nAygALm8hY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=csc1a39IvZlpwLxDggYadifC1tEq7JSBinO5ua04fMwhnQohsN0AxUBRZRjAD/4pC
	 JlDJa/bEYEm0WFORIN1uofrdV4fE6GlKfipcancMixygEOFHglwU6/Sq15YaZ4HOBH
	 tURYl3sQtQYQkn5cdgcssxTp57FGVpTErSx6KAIH24Wf1f0WOn67FWVyBqXxsw1DJf
	 nkxi3dO/P4SCL6p/04/rV8km6Aq80YEB27Ef7NPUQeEqByPqXx2Ny+JISgyrc7GjB5
	 sIA313DAOllc7eHpFOXBObvK64GADhfqEE1HxdKoj2ah1co/T6sXm4CUNrJHmQgGH5
	 Dplwdy6mJKmuQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Greg KH <greg@kroah.com>, Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
Cc: mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org,
 samitolvanen@google.com, ojeda@kernel.org, linux-modules@vger.kernel.org,
 rust-for-linux@vger.kernel.org, atomlin@atomlin.com, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] rust: module_param: support bool parameters
In-Reply-To: <2026041118-croak-serving-ff5e@gregkh>
References: <20260411130254.3510128-1-wenzhaoliao@ruc.edu.cn>
 <XkCBdVOQy3WcLA_L2YGegyYzAKKeqrm7gLpNUE8Y2Yj_9WksIbIc3U8lKkN5BfYo8zLmhZzMZq9vwC43s_nqpg==@protonmail.internalid>
 <2026041118-croak-serving-ff5e@gregkh>
Date: Mon, 13 Apr 2026 14:00:17 +0200
Message-ID: <87fr4zvzn2.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Greg KH" <greg@kroah.com> writes:

> On Sat, Apr 11, 2026 at 09:02:53AM -0400, Wenzhao Liao wrote:
>> Sorry for the earlier noise and for our unfamiliarity with parts of the
>> kernel submission process, which created extra burden for maintainers.
>>
>> This patch adds boolean module parameter support to the Rust `module!`
>> parameter path.
>>
>> It implements `ModuleParam` for `bool` and wires `PARAM_OPS_BOOL` into
>> the Rust module parameter machinery, so Rust-side parsing reuses the
>> existing kernel `kstrtobool()` semantics through `kstrtobool_bytes()`
>> instead of introducing a separate parser. A boolean parameter is also
>> added to `samples/rust/rust_minimal.rs` as a small reference user and
>> build-time validation point.
>
> What driver needs this feature?  Module options should be very rare
> going forward as they are 1990's technology and do not fit the "modern"
> kernel model at all.

Rust null block uses module parameters, and was requested to use proper
boolean parsing rather than overloading u8 parsing for boolean
parameters [1].

Best regards,
Andreas Hindborg


[1] https://lore.kernel.org/rust-for-linux/abfK4eji5jKSeO_W@google.com/

