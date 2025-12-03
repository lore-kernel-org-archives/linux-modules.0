Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC4F296BCB;
	Wed,  3 Dec 2025 23:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764805748; cv=none; b=Y/2KmYkLczN8NQUmcmEu2JWJ8yFpa5RFdFiPkpymtY7ZqLFLQ32S4LnziVC3b6XNOLZDiiDMbFFDzFlIqbK23lK2avySgZ37V9Bm94d+Ux7XVHWpGSgVCjNy/w15jdZbncB4NHlih6sgHGJalIN/ifejcv02HQDR/7URTBcHBDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764805748; c=relaxed/simple;
	bh=J/+FIirViUUi+YGxMp8IHXFYnDkyMH3CMmOhjYTIHC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CjWclysVabGPwJQPEWkVbOYKGdkfGJu10diQCooWgHVhhArXYFxyoqKesBCT63cVP1L7DoVy2PC+fIwj8OtwVldDepC0MblWKM/rUjq+T/o2pNPEh41iHOLzG3rxNjtIv35a9/s8wjC0XBgAvs3kKTy2zWLBRWrRITHH7IcI26s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Olv+HSoT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Olv+HSoT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E910C4CEF5;
	Wed,  3 Dec 2025 23:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764805748;
	bh=J/+FIirViUUi+YGxMp8IHXFYnDkyMH3CMmOhjYTIHC8=;
	h=From:To:Cc:Subject:Date:From;
	b=Olv+HSoTFPsf7+AnSSzqV+8u4qx0JLsfiEiJjdh8d8DKWQx49EOX6ORu4q/DhKMFu
	 vR2d/tOslJkNfI0pPPFFw8bNwr7ZDSpALj9/5stPOQnvg//cfra9g2EgsSAjNTC/xp
	 T9ivKhnRFEiiYDAhvWvrA/XmDoiSNWjm2+ExUzfC7Ue9cR6fG4aF2QKmBzpzmLao3t
	 o1HSJvUxnbtZKQuWLYNUyoEedX0iSQfOOEhKEbvu1iQ773r/BfgEeD6iVinyWrZw4/
	 7lehK5R8eDSLojUXw6uCWRb3YDmxnCTUQQExX0VA/dBZYDvC7FNZ92NOzllrupAAWM
	 AsVQR0PdaNmsA==
From: Daniel Gomez <da.gomez@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Kees Cook <kees@kernel.org>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Modules changes for v6.19-rc1
Date: Thu,  4 Dec 2025 00:48:37 +0100
Message-ID: <20251203234840.3720-1-da.gomez@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa:

  Linux 6.18-rc3 (2025-10-26 15:59:49 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/modules/linux.git/ tags/modules-6.19-rc1

for you to fetch changes up to 1ddac5cd7f278345b2e8298c930e4bffe0911a45:

  MAINTAINERS: Add myself as reviewer for module support (2025-11-10 16:20:35 +0100)

----------------------------------------------------------------
Modules changes for v6.19-rc1

Rust module parameter support:

- Add Rust module parameter support, enabling Rust kernel modules to declare
  and use module parameters. The rust_minimal sample module demonstrates this,
  and the rust null block driver will be the first to use it in the next cycle.
  This also adds the Rust module files under the modules subsystem as agreed
  between the Rust and modules maintainers.

Hardening:

- Add compile-time check for embedded NUL characters in MODULE_*() macros. This
  module metadata was once used (and maybe still) to bypass license enforcement
  (LWN article [1] from 2003). This change required a sparse fix [2] which you
  reviewed.

MAINTAINERS:

- Add Aaron Tomlin as reviewer for the Modules subsystem.

The changes have been in linux-next for 4 weeks. Recent 0day reports for UM [3]
and arm64 [4] builds were not reproducible and traced to a buggy bindgen version
combined with unreleased clang-22 in 0day. The Rust team has reported this to
0day.

As discussed previously, we rotate module maintainership among co-maintainers
every 6 months. Sami Tolvanen is next in line and will send the next pull
request. As a reminder, Luis has already announced [5] he will gradually step
away as maintainer.

Link: https://lwn.net/Articles/82305/ [1]
Link: https://lore.kernel.org/linux-sparse/CACePvbVG2KrGQq4cNKV=wbO5h=jp3M0RO1SdfX8kV4OukjPG8A@mail.gmail.com/T/#mf838b3e2e3245d88c30a801ea7473d5a5c0eb121 [2]
Link: https://lore.kernel.org/oe-kbuild-all/202511210858.uwVivgvn-lkp@intel.com/ [3]
Link: https://lore.kernel.org/oe-kbuild-all/202512020454.Tf36WHw5-lkp@intel.com/ [4]
Link: https://lore.kernel.org/linux-modules/aGiAF8IQ4PRYn0th@bombadil.infradead.org/ [5]
Signed-off-by: Daniel Gomez <da.gomez@samsung.com>

----------------------------------------------------------------
Conflicts:

There are conflicts with the pwm and rust trees. Both are resolved in
linux-next.

pwm tree:

  739ad9be61e5 ("rust: macros: Add support for 'imports_ns' to module!")

conflicts with:

  0b24f9740f26 ("rust: module: update the module macro with module parameter
  support")
  3809d7a89fe5 ("rust: module: use a reference in macros::module::module")

Resolution:

--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@@ -205,52 -98,9 +205,53 @@@ struct ModuleInfo
      description: Option<String>,
      alias: Option<Vec<String>>,
      firmware: Option<Vec<String>>,
 +    params: Option<Vec<Parameter>>,
+     imports_ns: Option<Vec<String>>,
  }

 +#[derive(Debug)]
 +struct Parameter {
 +    name: String,
 +    ptype: String,
 +    default: String,
 +    description: String,
 +}
 +
 +fn expect_params(it: &mut token_stream::IntoIter) -> Vec<Parameter> {
 +    let params = expect_group(it);
 +    assert_eq!(params.delimiter(), Delimiter::Brace);
 +    let mut it = params.stream().into_iter();
 +    let mut parsed = Vec::new();
 +
 +    loop {
 +        let param_name = match it.next() {
 +            Some(TokenTree::Ident(ident)) => ident.to_string(),
 +            Some(_) => panic!("Expected Ident or end"),
 +            None => break,
 +        };
 +
 +        assert_eq!(expect_punct(&mut it), ':');
 +        let param_type = expect_ident(&mut it);
 +        let group = expect_group(&mut it);
 +        assert_eq!(group.delimiter(), Delimiter::Brace);
 +        assert_eq!(expect_punct(&mut it), ',');
 +
 +        let mut param_it = group.stream().into_iter();
 +        let param_default = expect_param_default(&mut param_it);
 +        let param_description = expect_string_field(&mut param_it, "description");
 +        expect_end(&mut param_it);
 +
 +        parsed.push(Parameter {
 +            name: param_name,
 +            ptype: param_type,
 +            default: param_default,
 +            description: param_description,
 +        })
 +    }
 +
 +    parsed
 +}
 +
  impl ModuleInfo {
      fn parse(it: &mut token_stream::IntoIter) -> Self {
          let mut info = ModuleInfo::default();
@@@ -263,7 -113,7 +264,8 @@@
              "license",
              "alias",
              "firmware",
 +            "params",
+             "imports_ns",
          ];
          const REQUIRED_KEYS: &[&str] = &["type", "name", "license"];
          let mut seen_keys = Vec::new();
@@@ -289,7 -139,7 +291,8 @@@
                  "license" => info.license = expect_string_ascii(it),
                  "alias" => info.alias = Some(expect_string_array(it)),
                  "firmware" => info.firmware = Some(expect_string_array(it)),
 +                "params" => info.params = Some(expect_params(it)),
+                 "imports_ns" => info.imports_ns = Some(expect_string_array(it)),
                  _ => panic!("Unknown key \"{key}\". Valid keys are: {EXPECTED_KEYS:?}."),
              }

@@@ -329,25 -179,30 +332,30 @@@ pub(crate) fn module(ts: TokenStream) -
      // Rust does not allow hyphens in identifiers, use underscore instead.
      let ident = info.name.replace('-', "_");
      let mut modinfo = ModInfoBuilder::new(ident.as_ref());
 -    if let Some(authors) = info.authors {
 +    if let Some(authors) = &info.authors {
          for author in authors {
 -            modinfo.emit("author", &author);
 +            modinfo.emit("author", author);
          }
      }
 -    if let Some(description) = info.description {
 -        modinfo.emit("description", &description);
 +    if let Some(description) = &info.description {
 +        modinfo.emit("description", description);
      }
      modinfo.emit("license", &info.license);
 -    if let Some(aliases) = info.alias {
 +    if let Some(aliases) = &info.alias {
          for alias in aliases {
 -            modinfo.emit("alias", &alias);
 +            modinfo.emit("alias", alias);
          }
      }
 -    if let Some(firmware) = info.firmware {
 +    if let Some(firmware) = &info.firmware {
          for fw in firmware {
 -            modinfo.emit("firmware", &fw);
 +            modinfo.emit("firmware", fw);
          }
      }
 -    if let Some(imports) = info.imports_ns {
++    if let Some(imports) = &info.imports_ns {
+         for ns in imports {
 -            modinfo.emit("import_ns", &ns);
++            modinfo.emit("import_ns", ns);
+         }
+     }

rust tree commit:

  3b83f5d5e78a ("rust: replace `CStr` with `core::ffi::CStr`")

conflicts with 2 modules' commits. The first is:

  51d9ee90ea90 ("rust: str: add radix prefixed integer parsing functions")

Resolution:

diff --cc rust/kernel/str.rs
index a1a3581eb546,7593d758fbb7..000000000000
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@@ -10,11 -10,11 +10,13 @@@ use crate::
  };
  use core::{
      marker::PhantomData,
-     ops::{self, Deref, DerefMut, Index},
+     ops::{Deref, DerefMut, Index},
  };
  
+ pub use crate::prelude::CStr;
+ 
 +pub mod parse_int;
 +
  /// Byte string without UTF-8 validity guarantee.
  #[repr(transparent)]
  pub struct BStr([u8]);

And the second is:

  0b08fc292842 ("rust: introduce module_param module")

which causes build error [6]. Resolution:

diff --git a/rust/kernel/module_param.rs b/rust/kernel/module_param.rs
index e7d5c930a467d..6a8a7a875643a 100644
--- a/rust/kernel/module_param.rs
+++ b/rust/kernel/module_param.rs
@@ -70,6 +70,7 @@ pub trait ModuleParam: Sized + Copy {
     // SAFETY: By function safety requirement, val is non-null, null-terminated
     // and valid for reads for the duration of this function.
     let arg = unsafe { CStr::from_char_ptr(val) };
+    let arg: &BStr = arg.as_ref();
 
     crate::error::from_result(|| {
         let new_value = T::try_from_param_arg(arg)?;
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index d62e9c1e2a898..decb0849f3d33 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -133,10 +133,10 @@ fn emit_params(&mut self, info: &ModuleInfo) {
                         ::kernel::module_param::KernelParam::new(
                             ::kernel::bindings::kernel_param {{
                                 name: if ::core::cfg!(MODULE) {{
-                                    ::kernel::c_str!(\"{param_name}\").as_bytes_with_nul()
+                                    ::kernel::c_str!(\"{param_name}\").to_bytes_with_nul()
                                 }} else {{
                                     ::kernel::c_str!(\"{module_name}.{param_name}\")
-                                        .as_bytes_with_nul()
+                                        .to_bytes_with_nul()
                                 }}.as_ptr(),
                                 // SAFETY: `__this_module` is constructed by the kernel at load
                                 // time and will not be freed until the module is unloaded.

Link: https://lore.kernel.org/all/20251104154500.5acb5340@canb.auug.org.au/ [6]

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE73Ua4R8Pc+G5xjxTQJ6jxB8ZUfsFAmkwygIACgkQQJ6jxB8Z
UfvZ2Q//YAkK9V1Hk8imngjOxmiT1BGzo0feKSOgDHc0K3G3VkutmYMKTPymLS8Q
6EbvpbBRke990lOB7PloEL5ih27i9jmdL0QKpgU+uijRy5RssYEOoDMEz9JuKnqX
L8BzR61YzRoEIZBgZWij1Di+ITTu+qHn5VxnJUCqydDS4uqqcgO/9xibmN1JtToO
HpI63Y3R0VSMnJYfyVYJuKVCVWBhJzOzgIC8ZJCDUSceZlOAAjTsMyeUPS5m8j03
28o78aH3XTLRpL46vKBt4hpmeNrqE47tj6meMybVEew9SmEF78B9wbaQD3oR8Jod
BiFAhCNkwQao6aQAaKHAUZyWl+Udqsk8kJEgSeo/Sn5p1A6c2pGbddg++2W5jk75
gjYQEwdv+VZuym1YraM8E+mKIU/9+X1NXpwuusC5Vli7xz8DYf3w6llZNOgRQqTr
E1fXRQv2X5rUz3o6gzHgDF14XUEH0GM/3kYdUFSO9mqAQJCsMIRv0xIzRddsAcXH
ylqNX+o7cO+wuwcIvBIkhlYwS/MnAP/iDGFp8NTGGZsDrorCkNu5mFlO+xzGVLWd
gizeWnzgKrCNTzlR9oUzsGuPjTaQMBkNMTwlE+7InlLFH2CUc3vyKrkANzcL/vGn
jHBdg/pNsboAfbERgNG42d8YqrrCuLvYVrI6TRw9RhPPBFt8coE=
=ujQB
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Aaron Tomlin (1):
      MAINTAINERS: Add myself as reviewer for module support

Andreas Hindborg (7):
      rust: sync: add `SetOnce`
      rust: str: add radix prefixed integer parsing functions
      rust: introduce module_param module
      rust: module: use a reference in macros::module::module
      rust: module: update the module macro with module parameter support
      rust: samples: add a module parameter to the rust_minimal sample
      modules: add rust modules files to MAINTAINERS

Kees Cook (3):
      media: dvb-usb-v2: lmedm04: Fix firmware macro definitions
      media: radio: si470x: Fix DRIVER_AUTHOR macro definition
      module: Add compile-time check for embedded NUL characters

 MAINTAINERS                                   |   3 +
 drivers/media/radio/si470x/radio-si470x-i2c.c |   2 +-
 drivers/media/usb/dvb-usb-v2/lmedm04.c        |  12 +-
 include/linux/moduleparam.h                   |   3 +
 rust/kernel/lib.rs                            |   1 +
 rust/kernel/module_param.rs                   | 181 ++++++++++++++++++++++++
 rust/kernel/str.rs                            |   2 +
 rust/kernel/str/parse_int.rs                  | 148 ++++++++++++++++++++
 rust/kernel/sync.rs                           |   2 +
 rust/kernel/sync/set_once.rs                  | 125 +++++++++++++++++
 rust/macros/helpers.rs                        |  25 ++++
 rust/macros/lib.rs                            |  31 ++++
 rust/macros/module.rs                         | 194 +++++++++++++++++++++++---
 samples/rust/rust_minimal.rs                  |  10 ++
 14 files changed, 714 insertions(+), 25 deletions(-)
 create mode 100644 rust/kernel/module_param.rs
 create mode 100644 rust/kernel/str/parse_int.rs
 create mode 100644 rust/kernel/sync/set_once.rs
