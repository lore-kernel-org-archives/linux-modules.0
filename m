Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36B03D76;
	Sun, 22 Mar 2026 16:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774197335; cv=none; b=XZx26UC4aDMTycZ1a1dacTu2nMIxy1M4w2J5QZnR7Me/zHR3rmh03YEQjR/1GNIH2KiI87WD6MVFC+y3GPEicclgHgfh5O2vhpHGamP2kyIv8MNMfCua7WAC0+sEywFOiOxOdkkrl7/XwkqdY5nZRQy97zBOtbi3mJgmQ0qvEMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774197335; c=relaxed/simple;
	bh=OhFmczSWdRSHv/PJPv1Hi/xrwWK7ysEMMY4lS4c0YV8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kQeM9awa84PhEFoMB5Fc2zH5MgN+D+wbS+60uzgz6F7BuP8omahbwzQb/lp67PnAH8zjaha/PrbEyBDo0TP0rD+pUAcPctbGNcPZkZcuvCoY8QhbrLsp7IlVWpUK36J4U4iMuUNhX96x5RxnJTtWrLKx9tl/e7ixoIl1LhJoUhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cKJif8Dr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cKJif8Dr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C6EC19424;
	Sun, 22 Mar 2026 16:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774197334;
	bh=OhFmczSWdRSHv/PJPv1Hi/xrwWK7ysEMMY4lS4c0YV8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cKJif8DrRkdnjQvQpQ1ROtGFR6SXXhGNHyUc69cnnJ1Sdksze188JdndUhybUB3bo
	 Ab5Rl9JPtYSZqu5BrVRWTU9CduRNpLRZefkx+V5O6pTPO83blx7cJ1Bla/qlKyVQh6
	 SU64HJVBhsXQ8Z/AeQKwL7LTrncj7VIOY0VHC808=
Date: Sun, 22 Mar 2026 09:35:33 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>,
 Richard Weinberger <richard@nod.at>, Juergen Gross <jgross@suse.com>, Geert
 Uytterhoeven <geert@linux-m68k.org>, James Bottomley
 <James.Bottomley@HansenPartnership.com>, Jonathan Corbet <corbet@lwn.net>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, Greg
 KH <gregkh@linuxfoundation.org>, Petr Mladek <pmladek@suse.com>, Steven
 Rostedt <rostedt@goodmis.org>, Kees Cook <kees@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Thorsten Leemhuis <linux@leemhuis.info>, Vlastimil
 Babka <vbabka@kernel.org>, Helge Deller <deller@gmx.de>, Randy Dunlap
 <rdunlap@infradead.org>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Vivian Wang <wangruikang@iscas.ac.cn>,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 0/4] kallsyms: embed source file:line info in kernel
 stack traces
Message-Id: <20260322093533.c0aab4ed9f5eef9536d14c21@linux-foundation.org>
In-Reply-To: <20260322131543.971079-1-sashal@kernel.org>
References: <20260322131543.971079-1-sashal@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Mar 2026 09:15:39 -0400 Sasha Levin <sashal@kernel.org> wrote:

> This series adds CONFIG_KALLSYMS_LINEINFO, which embeds source file:line
> information directly in the kernel image so that stack traces annotate
> every frame with the originating source location - no external tools, no
> debug symbols at runtime, and safe to use in NMI/panic context.

Sashiko review hasn't completed yet, but it has things to say:
	https://sashiko.dev/#/patchset/20260322131543.971079-1-sashal@kernel.org
