Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818C6390600;
	Sun, 11 Oct 2026 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791730067; cv=none; b=bXJRe+/MGYoGkpm/OqxWo086FIadyoreeQb31cmuMBxOZrAfZZTyaDL4jNyNcoGmRU53BbhPHtXqakGg+TmRWdEPh2+lRZOozuQsOjI+x2uJeTNLU9aEBPHBUhdwH55gpn2Tt6pIsMnpCucvuw0u9VbvVQV/MeOPt31ukpDGUno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791730067; c=relaxed/simple;
	bh=rPqVmKUiJmxDmO2R21DhDbsqZ7Tyw1+2IA2spmdV3NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByescSyF3zwVmoW9b2c638LTL0CDqkjUaE3hPzaPGrhYku4az5zbA7jSHYMfgm4lwoCi/aGAUs143a0ll3ry/tI6bYcXDGAd0xTBGtX53cWEQHOur3XafqIA5tExrbmgNcmEvzrASKZNGhoKmgcpfwoLspr7EiKSh9/4sczr2dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=EZ4ICvnc; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="EZ4ICvnc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1791730064;
	bh=rPqVmKUiJmxDmO2R21DhDbsqZ7Tyw1+2IA2spmdV3NY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EZ4ICvncr5nK3zdPCv9oKSIThlFDRXnEsSvB9G4w4jXqRscdENSEyITkK+WbZDnGB
	 KJJFJmr+yL3+XP/qW/x+ubwPSXvi+t8YVmUc8MEoAxtFhmiK4pEMlz60n6yTOvZ6Ny
	 6xeD1NGIW99AUNGSV09Mt+86kJMZrTyr5uGJF9dU=
Date: Sun, 11 Oct 2026 16:47:43 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Gary Guo <gary@garyguo.net>
Cc: Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	Lyude Paul <lyude@redhat.com>, Yury Norov <yury.norov@gmail.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, driver-core@lists.linux.dev
Subject: Re: [PATCH RFC 06/11] dyndbg: make _ddebug::flags its own field
Message-ID: <47f2f7da-dd58-4959-9b00-b96a54ba6ee3@t-8ch.de>
References: <20261011-rust-dyndbg-v1-0-832e4039b71f@weissschuh.net>
 <20261011-rust-dyndbg-v1-6-832e4039b71f@weissschuh.net>
 <DM21I6LV89ET.346IBMXXFE97K@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM21I6LV89ET.346IBMXXFE97K@garyguo.net>

On 2026-10-11 14:23:21+0100, Gary Guo wrote:
> On Sun Oct 11, 2026 at 1:52 PM BST, Thomas Weißschuh wrote:
> > Keeping the flags as part of the bitfield prevents the usage of
> > READ_ONCE()/WRITE_ONCE() with it. It also makes access from Rust
> > awkward.
> >
> > Make it a dedicated field.
> >
> > The new field will stay in the exact same location in the parent
> > structure.
> 
> Incorrect.
> 
> >
> > No functional change.
> >
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  include/linux/dynamic_debug.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> > index 0b34343df594..b1ff7c0e9a5f 100644
> > --- a/include/linux/dynamic_debug.h
> > +++ b/include/linux/dynamic_debug.h
> > @@ -51,7 +51,7 @@ struct _ddebug {
> >  #else
> >  #define _DPRINTK_FLAGS_DEFAULT 0
> >  #endif
> > -	u32 flags:8;
> > +	u8 flags;
> 
> This will change the layout of the struct, because it'll no longer be merged
> with the previous bitfields.

It seems to work for me:

struct _ddebug {
        const char  *              modname;              /*     0     8 */
        const char  *              function;             /*     8     8 */
        const char  *              filename;             /*    16     8 */
        const char  *              format;               /*    24     8 */
        u32                        lineno:18;            /*    32: 0  4 */
        u32                        class_id:6;           /*    32:18  4 */

        /* Bitfield combined with next fields */

        u8                         flags;                /*    35     1 */

        /* XXX 4 bytes hole, try to pack */

        union {
                struct static_key_true dd_key_true __attribute__((__aligned__(8))); /*    40    16 */
                struct static_key_false dd_key_false __attribute__((__aligned__(8))); /*    40    16 */
        } key __attribute__((__aligned__(8)));           /*    40    16 */

        /* size: 56, cachelines: 1, members: 8 */
        /* sum members: 49, holes: 1, sum holes: 4 */
        /* sum bitfield members: 24 bits (3 bytes) */
        /* forced alignments: 1, forced holes: 1, sum forced holes: 4 */
        /* last cacheline: 56 bytes */
} __attribute__((__aligned__(8)));

(x86_64, GCC 16.2.1)

> The layout change can be avoided by make lineno + class explicitly take 3 bytes.
> Perhaps reduce lineno to u16 and have class be a standalone u8? No kernel source
> file (apart from pre-generated AMDGPU headers, which doesn't use dyndbg anyway)
> have more than 65535 lines.
> 
> Alternatively we can just say the layout change is fine, as for 64-bit platforms
> with jump label patching, there's padding in the struct anyway so this doesn't
> grow the full struct size.

I am fine with other solutions if the dynamic debug folks prefer those.
The goal here was to stay as close as possible to the existing code.

> Anyhow this needs to be noted explicitly.

Ack.

> Best,
> Gary
> 
> >  #ifdef CONFIG_JUMP_LABEL
> >  	union {
> >  		struct static_key_true dd_key_true;
