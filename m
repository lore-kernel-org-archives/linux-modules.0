Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6AD3DE426;
	Tue, 31 Mar 2026 20:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774990741; cv=none; b=DcTln6Y+yFGcr27Bmw7yMOt1fDRVTHw4Nbd94k5aHMJEZXPBBe/oCi8E6b6LRVcKC9nkiGqwnCK/kQCbHrzSEI6CPkmlcf4MGG23mQyvbKKKFkB5vS8K+CIojiFlM9bpFW0tj7YyRTGi8i21+/xese6bjUaJC6G2A/hrNYqDrz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774990741; c=relaxed/simple;
	bh=5fplL4+Tm6PvFoUMJgwNlIR3UOqxZ9EQUjoJoz+iP5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BhBokcToAB/amD7uWGm7H5GzcPeF/bB6wChLOK0OXVf9EFBqKcWpEpFYn4+SBI9C5NsXWCI/u8CDhmvLo4i/RjSQ5z4WfNYq/AgNZUty+knZXcjKqslh1uvS2w0M5WvfVS9HvsSbH2NQJuVyQSkAC/Fmefb4EGSLitBp6WbrmjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4qmfuVG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4qmfuVG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D488C19423;
	Tue, 31 Mar 2026 20:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774990741;
	bh=5fplL4+Tm6PvFoUMJgwNlIR3UOqxZ9EQUjoJoz+iP5o=;
	h=From:To:Cc:Subject:Date:From;
	b=e4qmfuVGC3qvezjik2MvQQtseCgg5cofWC1cJ9fAMwTMNitvMkLCHcuWprkIRkAqM
	 S5rTDFS3DFo8B90D8hy0XZe8/+k1EzgyuTgFKFRyiukO8Qpg50gdW3lCaEVVzmwrO3
	 n8ib5yJblRW0u7HP1qssGVSFdlDUD4IS7oL7CYuO/xYncwl59LZf0Bql/YsxVK7URH
	 pQVKrRtYqCGAg73e9UZ1+OdsokoW74YA5DwOMagyq5NFc75VaCVXHBrQKbRWQT9kuh
	 YGlVCZ0mP5QSyISMMjD7Mg2b0jQk0dxOXDE2fM6ggWyRKHgJ9McUpLGhfuC9vC9UOA
	 +m6PpEmh6u3xw==
From: Miguel Ojeda <ojeda@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	rust-for-linux@vger.kernel.org,
	Aaron Tomlin <atomlin@atomlin.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] kbuild: rust: allow `clippy::uninlined_format_args`
Date: Tue, 31 Mar 2026 22:58:48 +0200
Message-ID: <20260331205849.498295-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clippy in Rust 1.88.0 (only) reports [1]:

    warning: variables can be used directly in the `format!` string
       --> rust/macros/module.rs:112:23
        |
    112 |         let content = format!("{param}:{content}", param = param, content = content);
        |                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        |
        = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#uninlined_format_args
        = note: `-W clippy::uninlined-format-args` implied by `-W clippy::all`
        = help: to override `-W clippy::all` add `#[allow(clippy::uninlined_format_args)]`
    help: change this to
        |
    112 -         let content = format!("{param}:{content}", param = param, content = content);
    112 +         let content = format!("{param}:{content}");

    warning: variables can be used directly in the `format!` string
       --> rust/macros/module.rs:198:14
        |
    198 |         t => panic!("Unsupported parameter type {}", t),
        |              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        |
        = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#uninlined_format_args
        = note: `-W clippy::uninlined-format-args` implied by `-W clippy::all`
        = help: to override `-W clippy::all` add `#[allow(clippy::uninlined_format_args)]`
    help: change this to
        |
    198 -         t => panic!("Unsupported parameter type {}", t),
    198 +         t => panic!("Unsupported parameter type {t}"),
        |

The reason it only triggers in that version is that the lint was moved
from `pedantic` to `style` in Rust 1.88.0 and then back to `pedantic`
in Rust 1.89.0 [2][3].

In the first case, the suggestion is fair and a pure simplification, thus
we will clean it up separately.

To keep the behavior the same across all versions, and since the lint
does not work for all macros (e.g. custom ones like `pr_info!`), disable
it globally.

Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
Link: https://lore.kernel.org/rust-for-linux/CANiq72=drAtf3y_DZ-2o4jb6Az9J3Yj4QYwWnbRui4sm4AJD3Q@mail.gmail.com/ [1]
Link: https://github.com/rust-lang/rust-clippy/pull/15287 [2]
Link: https://github.com/rust-lang/rust-clippy/issues/15151 [3]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 1a219bf1c771..a63684c36d60 100644
--- a/Makefile
+++ b/Makefile
@@ -494,6 +494,7 @@ export rust_common_flags := --edition=2021 \
 			    -Wclippy::ptr_cast_constness \
 			    -Wclippy::ref_as_ptr \
 			    -Wclippy::undocumented_unsafe_blocks \
+			    -Aclippy::uninlined_format_args \
 			    -Wclippy::unnecessary_safety_comment \
 			    -Wclippy::unnecessary_safety_doc \
 			    -Wrustdoc::missing_crate_level_docs \
-- 
2.53.0

