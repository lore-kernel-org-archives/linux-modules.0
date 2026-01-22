Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18094369219;
	Thu, 22 Jan 2026 00:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769040007; cv=none; b=BS/rasvT627pGoEeS2G9TDfMy7q07ZJCGsQmqyTSlUzYewtHLU2sBjZVImwttbJzgkO6NmmOy221EbY/2Ws9lR7JAyMzQsm6y32cdTWb/orD6IwviN/cKgdkpaDMObAcxOywrjtPsZqRGSpkU6+o8fz5bK6fMu21WCPpBWjE5hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769040007; c=relaxed/simple;
	bh=avlUTdvX4nmGg3CyKiz1VkZdEmtyp8rApZZWOWIZtJQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RFwn5lyyb7nXeInr2GLMNM9Hi2GPuPSrtVK+Sl0nmi4wFozM2M9Li+UEEFOQPGTIJMqgKxX2KcG99jfRcD6D8Cbn7E0eGgeMOPxxUg5ihPmcY3EtMNsE2joVfP9qmrBVEIxxEQjRGbJsathZrBsMKLY+FwQXiRISlqbGaJX1fBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9cN0IiX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9cN0IiX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180AEC116D0;
	Thu, 22 Jan 2026 00:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769040006;
	bh=avlUTdvX4nmGg3CyKiz1VkZdEmtyp8rApZZWOWIZtJQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=s9cN0IiXJDliH1HWk00H784MVzTtjCj37y2NxMW8bUhzAV1kySickNN3OuT/VaH9s
	 3p0xEum9s13eLqcVsrrzeGK1I6Sbr3MTXG/4GXto0x6vttPk85i8CCaHCreVwgSFAN
	 I+K0+KzmRvbCeSf2P12Ne+WJSMnEVnBPLWO6v4b33ZS+Uy4TFQigORfhYj2JvEz1hh
	 4ntRGbIIrH0UHEvN+K8me6evJOW1xTapWvrJCqQVrmlax4iV9G+Y+6TV8kVOBjLn73
	 GHwuqOYQaUGOF9upUnCuG6yZ1GoF9EGJTQPcW4jr9rQrjx3JKTt8q9gLijnEVrPPXR
	 GvjRwya6bzQow==
From: Nathan Chancellor <nathan@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun.feng@gmail.com>, Sami Tolvanen <samitolvanen@google.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Jihan LIN <linjh22s@gmail.com>
Cc: linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260114-documents_gendwarfksyms-v2-0-297c98bd62c6@gmail.com>
References: <20260114-documents_gendwarfksyms-v2-0-297c98bd62c6@gmail.com>
Subject: Re: [PATCH v2 0/2] gendwarfksyms: Document build dependencies
Message-Id: <176904000365.4112982.18214786412044027667.b4-ty@kernel.org>
Date: Wed, 21 Jan 2026 17:00:03 -0700
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev

On Wed, 14 Jan 2026 19:47:43 +0800, Jihan LIN wrote:
> I found there is no documentation for build dependencies in gendwarfksyms
> while digging into Rust drivers. Though Yuli added libdw-dev to the build
> dependencies for packaging [1], it seems that there is no documentation
> about it.
> 
> This series documents the build dependencies of gendwarfksyms, adds a few
> examples for installing these dependencies on some distributions and
> introduces indentation style cleanup as suggested.
> 
> [...]

Applied to

  https://git.kernel.org/pub/scm/linux/kernel/git/kbuild/linux.git kbuild-next

Thanks!

[1/2] Documentation/kbuild: Document gendwarfksyms build dependencies
      https://git.kernel.org/kbuild/c/983233ac2ef1b
[2/2] Documentation/kbuild: gendwarfksyms: Style cleanup
      https://git.kernel.org/kbuild/c/301a02d405a3a

Please look out for regression or issue reports or other follow up
comments, as they may result in the patch/series getting dropped or
reverted. Patches applied to an "unstable" branch are accepted pending
wider testing in -next and any post-commit review; they will generally
be moved to the main branch in a week if no issues are found.

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>

