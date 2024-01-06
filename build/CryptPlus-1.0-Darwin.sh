#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --version         print cmake installer version
  --prefix=dir      directory in which to install
  --include-subdir  include the CryptPlus-1.0-Darwin subdirectory
  --exclude-subdir  exclude the CryptPlus-1.0-Darwin subdirectory
  --skip-license    accept license
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "CryptPlus Installer Version: 1.0, Copyright (c) Humanity"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
OpenSSL is available under version 2 of the Apache License, given below:

-------------------

Apache License
Version 2.0, January 2004
http://www.apache.org/licenses/

TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION

1. Definitions.

"License" shall mean the terms and conditions for use, reproduction, and distribution as defined by Sections 1 through 9 of this document.

"Licensor" shall mean the copyright owner or entity authorized by the copyright owner that is granting the License.

"Legal Entity" shall mean the union of the acting entity and all other entities that control, are controlled by, or are under common control with that entity. For the purposes of this definition, "control" means (i) the power, direct or indirect, to cause the direction or management of such entity, whether by contract or otherwise, or (ii) ownership of fifty percent (50%) or more of the outstanding shares, or (iii) beneficial ownership of such entity.

"You" (or "Your") shall mean an individual or Legal Entity exercising permissions granted by this License.

"Source" form shall mean the preferred form for making modifications, including but not limited to software source code, documentation source, and configuration files.

"Object" form shall mean any form resulting from mechanical transformation or translation of a Source form, including but not limited to compiled object code, generated documentation, and conversions to other media types.

"Work" shall mean the work of authorship, whether in Source or Object form, made available under the License, as indicated by a copyright notice that is included in or attached to the work (an example is provided in the Appendix below).

"Derivative Works" shall mean any work, whether in Source or Object form, that is based on (or derived from) the Work and for which the editorial revisions, annotations, elaborations, or other modifications represent, as a whole, an original work of authorship. For the purposes of this License, Derivative Works shall not include works that remain separable from, or merely link (or bind by name) to the interfaces of, the Work and Derivative Works thereof.

"Contribution" shall mean any work of authorship, including the original version of the Work and any modifications or additions to that Work or Derivative Works thereof, that is intentionally submitted to Licensor for inclusion in the Work by the copyright owner or by an individual or Legal Entity authorized to submit on behalf of the copyright owner. For the purposes of this definition, "submitted" means any form of electronic, verbal, or written communication sent to the Licensor or its representatives, including but not limited to communication on electronic mailing lists, source code control systems, and issue tracking systems that are managed by, or on behalf of, the Licensor for the purpose of discussing and improving the Work, but excluding communication that is conspicuously marked or otherwise designated in writing by the copyright owner as "Not a Contribution."

"Contributor" shall mean Licensor and any individual or Legal Entity on behalf of whom a Contribution has been received by Licensor and subsequently incorporated within the Work.

2. Grant of Copyright License. Subject to the terms and conditions of this License, each Contributor hereby grants to You a perpetual, worldwide, non-exclusive, no-charge, royalty-free, irrevocable copyright license to reproduce, prepare Derivative Works of, publicly display, publicly perform, sublicense, and distribute the Work and such Derivative Works in Source or Object form.

3. Grant of Patent License. Subject to the terms and conditions of this License, each Contributor hereby grants to You a perpetual, worldwide, non-exclusive, no-charge, royalty-free, irrevocable (except as stated in this section) patent license to make, have made, use, offer to sell, sell, import, and otherwise transfer the Work, where such license applies only to those patent claims licensable by such Contributor that are necessarily infringed by their Contribution(s) alone or by combination of their Contribution(s) with the Work to which such Contribution(s) was submitted. If You institute patent litigation against any entity (including a cross-claim or counterclaim in a lawsuit) alleging that the Work or a Contribution incorporated within the Work constitutes direct or contributory patent infringement, then any patent licenses granted to You under this License for that Work shall terminate as of the date such litigation is filed.

4. Redistribution. You may reproduce and distribute copies of the Work or Derivative Works thereof in any medium, with or without modifications, and in Source or Object form, provided that You meet the following conditions:

You must give any other recipients of the Work or Derivative Works a copy of this License; and
You must cause any modified files to carry prominent notices stating that You changed the files; and
You must retain, in the Source form of any Derivative Works that You distribute, all copyright, patent, trademark, and attribution notices from the Source form of the Work, excluding those notices that do not pertain to any part of the Derivative Works; and
If the Work includes a "NOTICE" text file as part of its distribution, then any Derivative Works that You distribute must include a readable copy of the attribution notices contained within such NOTICE file, excluding those notices that do not pertain to any part of the Derivative Works, in at least one of the following places: within a NOTICE text file distributed as part of the Derivative Works; within the Source form or documentation, if provided along with the Derivative Works; or, within a display generated by the Derivative Works, if and wherever such third-party notices normally appear. The contents of the NOTICE file are for informational purposes only and do not modify the License. You may add Your own attribution notices within Derivative Works that You distribute, alongside or as an addendum to the NOTICE text from the Work, provided that such additional attribution notices cannot be construed as modifying the License.
You may add Your own copyright statement to Your modifications and may provide additional or different license terms and conditions for use, reproduction, or distribution of Your modifications, or for any such Derivative Works as a whole, provided Your use, reproduction, and distribution of the Work otherwise complies with the conditions stated in this License.

5. Submission of Contributions. Unless You explicitly state otherwise, any Contribution intentionally submitted for inclusion in the Work by You to the Licensor shall be under the terms and conditions of this License, without any additional terms or conditions. Notwithstanding the above, nothing herein shall supersede or modify the terms of any separate license agreement you may have executed with Licensor regarding such Contributions.

6. Trademarks. This License does not grant permission to use the trade names, trademarks, service marks, or product names of the Licensor, except as required for reasonable and customary use in describing the origin of the Work and reproducing the content of the NOTICE file.

7. Disclaimer of Warranty. Unless required by applicable law or agreed to in writing, Licensor provides the Work (and each Contributor provides its Contributions) on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied, including, without limitation, any warranties or conditions of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A PARTICULAR PURPOSE. You are solely responsible for determining the appropriateness of using or redistributing the Work and assume any risks associated with Your exercise of permissions under this License.

8. Limitation of Liability. In no event and under no legal theory, whether in tort (including negligence), contract, or otherwise, unless required by applicable law (such as deliberate and grossly negligent acts) or agreed to in writing, shall any Contributor be liable to You for damages, including any direct, indirect, special, incidental, or consequential damages of any character arising as a result of this License or out of the use or inability to use the Work (including but not limited to damages for loss of goodwill, work stoppage, computer failure or malfunction, or any and all other commercial damages or losses), even if such Contributor has been advised of the possibility of such damages.

9. Accepting Warranty or Additional Liability. While redistributing the Work or Derivative Works thereof, You may choose to offer, and charge a fee for, acceptance of support, warranty, indemnity, or other liability obligations and/or rights consistent with this License. However, in accepting such obligations, You may act only on Your own behalf and on Your sole responsibility, not on behalf of any other Contributor, and only if You agree to indemnify, defend, and hold each Contributor harmless for any liability incurred by, or claims asserted against, such Contributor by reason of your accepting any such warranty or additional liability.

END OF TERMS AND CONDITIONS

____cpack__here_doc____
    echo
    while true
      do
        echo "Do you accept the license? [yn]: "
        read line leftover
        case ${line} in
          y* | Y*)
            cpack_license_accepted=TRUE
            break;;
          n* | N* | q* | Q* | e* | E*)
            echo "License not accepted. Exiting ..."
            exit 1;;
        esac
      done
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the CryptPlus will be installed in:"
    echo "  \"${toplevel}/CryptPlus-1.0-Darwin\""
    echo "Do you want to include the subdirectory CryptPlus-1.0-Darwin?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/CryptPlus-1.0-Darwin"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

extractor="pax -r"
command -v pax > /dev/null 2> /dev/null || extractor="tar xf -"

tail $use_new_tail_syntax +205 "$0" | gunzip | (cd "${toplevel}" && ${extractor}) || cpack_echo_exit "Problem unpacking the CryptPlus-1.0-Darwin"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;
� }��e �}`\E���<��ERh�P�PJZ�t7�>x$M�M�kIR(�n7��te���#m�b���j�蟫U��\|y��u��P1xN�E��X���f���ٴ)��L;g�3��7��|�͜9g[C�E�qvn����Rda�e<$'z**+���nOu����{����x3�.�H����P8����u:H�ޞ��#~H\+�8�Z�K�©Di�V��[F��/wW�ۿ���Z��ˆ��o������&
�+�� ~:��|A��=��?�A� ��-�-��q�ƣ���Җ���H��,�oRq��n��$�?�L�&l�-������XqDoB:G0藶�Xҟ��T�;T�#�;�?�H�C��N����\=V���ߟ�lE���H{Ԃ^�6
sT��?l�;��ږZݺ�͜Z7%�Q�q.yk���4�-�!��n�_q(�Km���4�e�Z�8m�d�ȗ�^�k�2:䫁�Yݸv���1-{���T���i���e�����M���$WDN�r�����i����<�%��w.v	[�	������cW�Ҭ�P߃�.�;񳩜EӚꚓe_��-�g�e7���D�N���	�o&S�{���_U`�DZ�k�\�J����@xQ4�/E�pM9J}�--W��t�Z:_���\p:����K=�a�F���u��|c�歉��Y�\� s����*6�0��q�s���8�9�q�s���8�9�q�s���8�9�q��n}C�+�_/j��v���{���;"�6	BC�C�Gz
�?Z��G
��6��vX��ȑ#J�z�����ٻ���u�/\
�m��H75"?M�\i�Y7���h5��6�7�g	�ҏ��V�����!���7���1?��O��%�����K���:�xe��~샒z!j��"��X럮ܵn��@o@'��m{z��~��=�B�w�4l,�Ƚ��Q=�<�=7�<'�@�{��\N��~�joC��A�l���p�Uxgw�6`���Y�"VDQ��Gt>+⡞���5r����DCK�eL:���Fh��m{�.��6Y>	nfh_h�
�Y���6&��u�b(���>y*��v��+X��P�g.�N0<	!���1�ɂPqd��pv�C�z/�z�����3��|�*�5����12�n:�!y�$V�.�LoJ����Jl?��y����?�.-݁��V`�x@~}-��f��xi���i��%�]�������O��Y/S����>���>v��c{� ���+ysP�����|������A��{M�m�eL
����L圵���+�:�p��E]g��t�Z���Xg�C���nX����Եw�,��=&�:���z+,�ʺC��&Qu3Q�����Τ��v���HZ���2~�@�S9�ᘂ���^�D7@�c�@z�{��Iz���$�W~�]Uz{�GW���+��� ��=�_:����	3N�;7<��t��-`��vP�V��j�_��PP���e���^�����c���x��)/�d�d�|��E����` ������������ �~˾��Կ����{7�����VY��s����W���V��'��u���~�]���[�{����0���f��F�LC�����\(��۬/�_��<������1����'�[
�o5*b�,�8����s ;{e��X�$��O�j�~(�[�[e��=��=�r0���Px��W���p����i��4WC�#I7 ��2ѯ�^�����G�b]�^��E�[�����#�ё?j�/f����ɿf��`Ept���W{����c��o[��rK���ۮ�#O1���OcoB���
e�����~�^M�M}���u�~���=kk/����`D���i��De^*p���4%�O1�5�g��jH�K��@+��e�xM��|��l^����]��jm�1%�F�����C�߇�Z	�
�~��0�fN�����E~ȷu�Bd�T=�߹"�3֩z��0���^|��09���Cн�[�$M���q�[�A��b��4����)T"ݯ�3pp��9���\��B���E4�����S����(b��!o)�]tc7{�ڣ���|Š���;��$�M�꠼A�����xh���+���wL��+�i*W&����P9�cl�'�{bC��A��y%_�>8"�U��>,��? ����BN���T����|���E���8=&?�b�=̬�Iy��.J�Zo����/�	�c��;pJJ,�1]�<�ܨ<T �����]Z�^�{\X���F+K~)����_��tH����]޻p�S_��y��m[�a
J�W&�i�u��4e=��+�Ds�
��4��}��LC�u��!yp����}9ђ����I1YU�/�DÌO���Eɪ�!yw-��O���k�V��y�Q��լ��Z}���ZT���~���Ѕ�	��!���;���t��m#`�NS���X��It�&z���n�½�˼�������d1,�^�=�{���*�(l@(�t%M
4F�#�eށf��#�����݁���B�{������?�M�@�B�H��������<��"�{e�I�"�n(}o�MU����D�q�lM����~
�ϯ�;w�HE}���A;w�4Yi�C!�0�ۊd���3��"9M۩�^�.��������0�N��ߴ���j��E��2�?��E�V�D�@~��/Ҍ�3���x�|�;�Vc჏���
�v�_�Z��JY���T�i�Г�3V�7�g��򴵳���ec?Y���p��FeZ�N�sHɱ��G%��?��y\�^�׹���2�Gz��0w��& ������6��t�n��a�˛�`��e��έ� _[yp�˰����nS��5���<9]*��h_�%gi�ea���f��ˑ#f{�+���H�����_Q����\�n:�Ξ�|2�=����%V�g�;=�ý�w�y[�罠ď�۷�f�����+�9�ݶr�R��h��
��eჩ�����.˷-E�i?�35�)m��r��[�;���6�V�N�����1�G-���Z����tķ8��l��fq
����%���K�ƃ�?o~s���w�ĉ����?���] ����S�{N���>
����Afm������`Ò�7����{D8�@�`{�XW�f�Nq��o����/��k����=��vj��37㧗����G�%��l3f잇����x�����wF�oO}�Ͱ����k��+����_�p�"8Ȟ"<D�T��^&�^�n�+ش�`Y�cf�ogk��ոLxr��'�jl��򥼀=,K=7��RZgA`�x�>�Vҟ������`��z0���ES�^�K�,\�d�������η�A���{��M�5=�ص�j	o�6��L�w��v�j�ɬʏ
X�ie�b���O��8����������5/��K��l|��!Y���.��Y��U?���{����2W��홭�"���<_gJ?�z~����t{
���P0��ˠw_+������m����ڨ����Q�	}gVZ0�
7ݖ������m����'D]��v�)�,�f��l�a���3���]s�!d��V����ayd��|8�μ=/�*�(/K{l�?��fI����������^^=�
�ޝ:(����~��{�]J�2�q3����_�H�����|������rJ�����.X��x�,�x��c�]����@t�t+�]��Gr��KM��R��1�c9
� *�U�,�F@~���a��1��r���;m�b{���_y4s3�|��\E�:�B9�2]�)��"���f��k����d�=ğBc�C�K�<�^_f��v_�[�j�=9h*������'S�5>�CB�
����8.�]ݿ����\�/�
~��@��^~��1ag�yu�)�ۙb��=���C��G��э��]L���N�ɠK#�����r=��r��w���\�����uU>��p�~�-6���׆ނ��p�Ɇ��lx�wД/�&�F�|?K
�z���폹�&}����m��,3��E��ٚ������Z���$;щBz�i��5>?��Ǉd�<eУ�V������?e/��{)W =�.J�W
����߲���ð8�o+�hZ9��x_��-%�օ�Ο��A!S�h�s�BꬽӮB��?T�i�n��X�,l�><b�?`�~�,T'ZT�l��4e=��������J��Oт�7.$YB�ܳ@�]��o^��w ���z&��(�Z;�L�����^n�V�.A�Q�~|�>**��N���3�ρ��<���0?(� ���_(��nq��j|��gp��&ffY����zl��ǘZaeT��Ňn�c���%�*����t|r�!;�2�V�[�k}|��+���F���3�L�Di�<�/w���T�?��4�~�k>c����z��2���Z�0W�C������[�r[���̱�����a��/]3��x$�|f^����w�d��<�,��6���^��Q�x���cG�z�vH�t��Gy^��ye|��S����a����O�$e	�5����[��dH�Y�_Y"(O��s� 4�Ȣu������/����������������v������e��a���YU�˷���$����������*����+2R�\��5l�gt������һ�L��d^�h��z�{��$.7�~������D�kʃ=62F�s���ä�ayà�?��In�gz��g�0[<�a�m2��xĎ���M���߫��6��i$��� 1~{n�,�"v�l�|ɋG����c�����&��p���r(���h��G٧�Ȣ��s7�vW~�\���!�gs.��}�=��������Ŋ���+���,�N^
��L�Ҝ���3,-�����s�������2|@ax�T_�Ů�&{ٶ�%�"x6|����vg���h�	wW�8������ r�+����X=�p���bF�׫�X�����a�:t![��ƑD90����ecT���(ք�=<f�Bw��G����'�Oرy�]fx����Nm� �t����y-�g�������H�&.l�w��骲4�g����$��	n�������2֙��]�J�����-�ޛ\��ޑ��t܆YA�pn�@��c�HT��4�-���0n�z�n���~
�}n��Ffz�7�� {�&��{����>,�߅ta �>V�Yp��a(�'��aF9,*Ϡ�����D�,~��nxU=P��YٝO��WO�e�?���c������G���+��������ͥ�=;����w����?����G0ϧ�����������������q.�&���?=��w/?��w��R�]�lf}w����~��ws����'�K�w�3����g��5璾���[�ϰ�w��<F}���E�}�:�t�I�}�)U�%O7��N��w�sT}w3����w���Q�-�s��9&}�ꓪ��7۠�fk�U��3���'��w��=&}w�?��Z���
:}�����v&}��Ӳ�w=l�:"���9lA�kR�ˮ������"?,l`}�{�A�v0s�O��3>5z�؅����	���g~�,��L��F~/g����揥��z�,��ʯ��	����Ǐ�wF�a�7'�cwX�ǩ4�sXyWG�
���JUy��W����#�)�����o��}��ی 𰿆}b�Y�{󇥺�n��� ��E��^Йi�`�}��=�Ϧ�Q��,�2�_�g^��߿�3,[����ʎ�YU�~��zSڤ�������Y��;T�u��O`�۩H������JoѦ�$j7�m@^[�R��0`�[�}�Q����i�y&g�_�5Y���n?E}G�ޔ�K��|����R���հ{�*�G�=����5ﻰ��k�9�gMV������ώ��^����zS����0����-)�����>��m���3��۫L�+OD���yK9�;��
o����-��ShR(�v���A�YLq1�|�~U�����U��"�v2>ͺKؿ�U Zz��m�泞I<T|�e�B�
$��<}����{Tv�&��4`��|��0��;��$����i���|�L���>�O����TI���f��wY�e�|��
��Hx!$ٿc�����c�6�)�rF�����������זm���Ʒ�5��j��x�1��]?Sk�"�5dY��3L5n˱���U�Д�6Ôɬ�vj�m'�$��#' ÷��b����ΰ������ORfg���ˆa��H�kl��Aճ�a��Yi]D��c��Ye�fV�U�`�:�,b��U�8��j��,�r�𶠲ڻtR��f�I��!�E��m{�Zd5[j,^԰��YJ�����ڬVk�E��?�1���~D��Xs�Z-��M��6�b�>��@.��Ka�q|�`�&�^��P�b�O��w����1�_V�U&���O�X��&?dvã}ܠ��o�i��J��@�GO�G���������L���4�|-3�В�/�f���S�z}J����6LOC��+�/�&hv/�ϟ�qZ��/>t�uz��djD�6��"A=�c�����yz���?q��0߹d�U�hy� VJ������O���q~�����<�p	��~=��}�L�?�Sf�`�!��m˞��Ei�r�|��z{U���՜7��$���xS_O�D�y�e���}���0g��|������4/Fy�}K^�Zg���1Ƃ�*�YO12Vcz^��R�%��dء�wL��Y����?u���g��4K����1|������H�i�'���[�ແ��Ǧ��6�˺�>��>+����3�����Z>�=E�������Xg�+�����C�W��)�3U��~�{*p�$.͹_[���<��V�G�}d���o��^��O����]�W7���J�+�)�_5��!��)��q��^fo �=Y�ۛ352[t?��D�A>>%��V���lJ4�K�+Pڔ�l2��x�-�{�c<ȑ����l��`��~vw��L<ʧO��o��V�[�a��ޔcOJ\����$��%�>ߙ��y�|�OX}��N���mD�Z��E��+�v8NW��8�39�=`�3�a+���XS��Q���=rމ
����|�����Ĉ�)/ֽy/+����fU�'�GZ��K铋&Y|�〼� v��}{k��H��������A}�9̶
��N�j�7N��l؍;	�E������N�W֟�N�?$O/H[l�L��|�`}�,pn�,���_���Yh����g�·���'
�5�V�]��5��wZ�F}�S0���e>CZ��������0��?���7Ϳ�|��_�m��?��%���<���4s����}yZ�vf~��-�\�̳�G����H��y�2��H�5#�&�e���!�kv�9om�����]��{׼��`3�)��}����1�{��m�C�\�Op__���Le6�4׿.��y���|�r/d��F�t[���O|�V�Tַơ%:�� �}
�쟔 ��.]�N��A_�ȥ�Ё{4oxd:��<v}�&�j�Ӿ?e�>���X�?��������{��9��k�����7r�34t�Ye���G����\#��qɅGn�g����Cy�o�(��
��;=�ȹ��캏]�����$�����3��Kv}�]�����"��Į���;v�=��ʮ2����ήo����ɮf׷��0���]�a���U(�k���v-`���:�]O`�"v=�]��\v-a��캀]K��ͮe�Z��U캘]����z�ְ�rv�g�����W��U��1v�Ȯײ�'��zv�f���&v��]w��������Uv�gׯ�����v݃�;���N�?�E?�v�k��`���.�&פ�t	�]���"�S��S�^t	\e��I���>���K���!��]��K��k��뺂���.��%|�5�q���<����y@|�f{\sgOz,�5�9��~��Rn���a�Л����_������� �Q�_���t�K�8����L�pW�[.5��|�&�T�<A8o�_X����/���K��:�Y��|��1�RGo� ���
���֥��#�
� h����������~~���߂�_�����«n���6q��ն�st��C��S��v�����ȿ�%\v�.a��߸�]�kٽS�����\B`�s.��t�%|εM�u���Z����?�K�p�k����/�́�ι���M�S����E���~#_x,�
����>7A蛈i��8��a� 	k��_O~8i�e)����:c�P+��V��ũ�AX��^�h5a� x��%
n��|IX;^}�ë�ЋW�_#|, ?u�C_{��[N�9·s.�tf9��6��re���H���|��F_����.%����KE�Q֥� �o$BA?��1��Z�*&�Q1���Җ�L�}Q[�&���#�Y���	%�Җ2m��X[ )icV�"�0$cq��9'�irRL:g}���6I�=KʄE�R<�H���E�p`�"�cQ"\$m	n
D:��`,&x	,ۤ8��'���$ŰH$�hDbu%�H*�����D�*)Y��oc/]JiBP��y@K�;b{ �ڄX�͞"O�4R2�3�:Y�5� ��$)�, )�c����h����~J�"�:jz��������^�k���CrP�5�V#�t�1DB������b&
��F�J�Tk8\�,���C	\i�.��"�C�DH�v7~C��}#�=�6<�*��eޖ�8܉"�]�����b!��6%�}P@��sA%B8 ��n�� �/�G1�[c:����@�A��.��pt���p��E0�wC���B70ݏ��@�7	�;�|�]�¾+!a�G��	B�f�%A]!�a'����C�@X�	��<���N�[�.Hx�����
u�,��\EԸ����Ɂ8HT�'�6��|�y>�<ApM�zM\��.\��nO\}�6��L�4��$�F`�_3Kp̂z�
!L
��ah��3��p��P.�A�\�U3��\�B�w!��6�)��@c1ăM�^
yA��_ �a�@^�P��^�[������� �?v��r��7�� �[��W�]����n�9�R�Ga>�(�Ha��(�L�
�R8��(,������H�IΠp&�'Sx
��(<���(�M���A��E�H��Sx�s(<�¹�Ga	��(�O��.�p!��.��M���2
�)�����*
�)\L�
�R���(��(���
k)\Na��z)\A�J
(l��
WQ���5��p�>
/����f
[(\O�e^N�
�`��-8�q�s���8�9�q�s���8�9�q�s���8�9�q�s���8�9�q�s���8�9�q�s���8�9�q�s���8�9�q�s܇��������8�9�q�s���8�9�q�s���8�9�q�s���8�9�q�s���8�9�q�s���8�9�q�s���8�9�q�s���8�9�q����~�!� \	�Ks/��Y�ݚx�B�ݗ\��A}�+|	���7�����C:�����\���F�{��~V��	�����w�'�
������z�����~ �����׊|!wW����G&������	��@�i�y���Κi�����»w�c����)BN�T!�%�iB���o:A�y��B!g��"�ݻ��4]șs���|����q����$���?���-�!��׃��>�o��:S�]��� �_����0�g����g
����
_�:0,����$��t�3G�ix-AoS�_�ǣq"E:xL��� /���}�&]�0�j��"#�f]\��n���a������D�Z󭫥����H�z)�K�Ea��E�	A���"���I��Xd�H}f��f���^�*ٖ�b�J��@��G���bP;ý�9�:�mR<�%�"�!���HHR\{Gǲ��)"���� ��kn^���6ծ���.�
��"m6wR��]�T�}q����G6�"m�&)�B��\[�ǒ�^섞�hL�$a��h*�]ۜ,��=���@"$2�����n����B�Dc����%����8�x���Ǖ�*"R�%��
I������:턆����~-�*������=��ަ��nY�MW��P4ᇲ�*%�����6'=�p�8`C����[T���o�{�Y�ܭ�6 le}�'�-�������t���?�5&yC�I˥h{FZ���� T�3C��@"�@��`�d��h�R��A��5u��b�(���Pryu����vW5���T���c�_�g�k�1��HAGjZ�\�?fB�WΉD���g�1��1g�l�������IƷb���}ُ���7t4�t��*-s%��!ʫRX���vOB0�03AU��hD���e��.��	e�����3���&��FzA�n^MDe��IkP��5:�V��D
��� LTX�̱�����n��XɌ2���^srIR�w����X�F�Vb�U,�{�U0+X�Y	P�s�����~pK�O����	J1l�N����0�GIXKmZ
本�:�lK#���=Jn�w�16��5�t5�_��>�#����V���/SC�����wJ����愰3����!�� I�(���l��3\��\��~aj�0�#�u����@S"j��Е�����K��{ V1y�l���ka�&������&�]�<�e����W�0�c�d�',�>Lv�e|�#�ǅ�']��?�̾�b���%�x�BK�W8�0Y����7r����`�q&�����3��t��['�wN����@�W�|.T�e&�a�v�Ī�"��[���·J����"�'1�XYF�'��M!a0�Ix&�Kxn�����2B/�	}&sޖE����!���&�μ.�{y����BM	����JM�aM_�r�iQ�P�'�����
#�B^/�\VDO>�A~�pk>����a�t��I���(��pG>�p$����5�����0�����ZE�oq
��Q�O���䣠����ׁz��$��s�|��p(q��&�ͼ�Pl�W� 8����5�A&�gY�����W\�6}�ܪϕ���k|�r���:��&@-����	�iH��-�o�9�]�M��@Kxb"�'v	�������6X~9.����F���/������q@e��@K�ic|Ϥ.ồX��c"��&A&���J��$l���_���uz��ũ�m���)S�r���610c���4�Wꄧ&A��]�6�oL~wbam|=}��%Pg�ц'K�q%��dh�nP8y��(5��㦏W�:���/L������p���[N�0MȩC�T�OfKU�i�5���Xũ�%�h�OS�H �	R���iR��ߎ;^�&_H��	$wm�'�N�\��jr���K�[���tV㝟� 亅����'T���U������B�s�V3�]���ېhhm�q����W����@��JY���/.����V\�[&�D}�����*b���0���#��Ѱ�g:�O�CT�G�Ta��������a2�O��������=.׍�6�$%��k���{?,�	M}���
�^��b,�F�[@|�L�ܓQGf[�GO�?�=L���/��%�u��Љ �;	��!����P��3`��6�Nx�z�����L`v��ɕ¯�U�YOxz�b�(<�!	���>��'��c��1��u
��P��`mmԠC���I�2Ok2��s�p�L�y�ϱ�w�r�³3<­3A���?�Yų��~
�����~��L]�z�m��L�����Y���#�!�(���W��45<r2������ɪ��M�M�;p��"���@j�c��1`���˄wO��ze&kO�a��b���L���sJn�`
��v�N9�����Z_���.C������J/�������,@'3nu=9���~>K�u��*�Y���O���&������7tv�c^d���Q��Ϟ
M���p˩�ew�S�Y�/G�I�>c��}5���i��nэ�H�q�#.�;w���q�kD�F_zQ�E>H.ADw���u��yn1&r*>w��>��Y��]pC��>d�E&��Dw�AY�.Q�� OJ,��1,�f#��j��jj��$�!E�x�W�q� �.��������7��q�Ę{#��Aޠ~��>W?�Gr]���{������-��-�o?C�tu>���9�9�c��/#<2��=���9�a7a�Yw�Ix��!�C�W�T��	��/>���J����w�-&���&�^��s�r�#�#|�~�p<H=}��	?EX(�x��D������n��#<L���Up|!a7�o$��}��G�	7!|�J��/�8F�6�݄K�Q���� ����5��*�o \D�?��Χ�	o"�G�1�/\@�����7	��[H�'��p���	���c?a�	_F���������w�,���E�~��%�Gx��䳔���{	�>Bxp��z��p|5���Gx��G�ʨ�9^A�G��p?�	�WN�}�;�	��ܧXUA�	?D�Gxz%ɋ����k8>���'�N¾Z����_M�&�Cx�����s<1�G�z���_"<@x��_�w�>L������Gx�p�2���7."��p7�;	��������H���>��+8N	�K�Gx�p��t!ɗ��>�"�7��	�+9�.ፄk/���_!�k �k�<��!¿%<B����k���>¿"�G����/��.��1�n���	w�!<B�-��*�O=�'$�M��p?��>�K���xa7�	��Bx��+�?�-��k8�A���=��OXI�7q�$�M�g�{H?^��]��	�!|��	�� &8�v�&�@�s��"|7�$�����&��~��]�p|���I��#,^J�Mx��	�'o$|��;	w��>�'��˄�A��'��"��ل�	W�Bx%�>�W�'�Ix�p7�A·"��Ä�%<B�I�B�Ä����H�`5ɟ�i�W^@8L�" �#|�p��L����9�!\A�˄�	�p�	���$a��N�� |��p���ل�� |��J������-�^���&\A�V����A����?E8I�e�7�������#�3���"�/�%<B�������E��%,�M��p?�6��'�	����	��������>q�O>�����~�����z-�9�]P�V��"�r|�p?ݯvq<H�?O����{��y�n�X�O��r8"�v^���F*o�����>�7Dx�ҿ�`J?)��'<��O�x9�"�	�8������Q��УʿWʣ���D�������wS���o �������������7��R�YϘ@�E��p�K	���F%\D���}��'�v� +�L��.!\���M���~7(���NX�����8ǳ8 �N��^"�#���0�O+���pw��'q��+L��"�&U��7�!|�!��!�G�!��d���=ɞ�$b��r��+�>؋�_s�p�F�7L!��_��� �/���p�<��	t�Tj��+�hh'�s8~����_>��7��M�w�����i'�<�~7�>���0ѯ)��Do���H�����o�S�}��?)�H�'Wr&\s��	o$�k������S��Ix��c/�n�_����	�tp�a�?$}1�DJ/r\KX��"<D�a���	�~�p���N����$�?i��V�}��� �¿%���&��x��B�}���Lx��?�W0�_",P��3����:�������?h�O�����k�'�����2^c�3��y��?h�?7�W�|�)z,p��3��&�̀�c�?3�_���/<e��k�5��q����(���c����O9U��V~Ԁ����M�c��k�_h�q���5�!~Հ�:]���jn5�n��ŀ�6���/�5>l�'��ǳ�s�����eg��G��z�ŀ?c��h���z𗁿��W���G�_���?�~#� �V�A�m�%���;�o�q�W����8�����~%�$��.�[�7�o	�U�W�_~-�k�_�ශ��'�w����ස_��f��xt'����g����,�ρ����;_ �/��x<��e�_�UׇC��I�[�Y�7��a!�]�{�*��F2�}9��Wp<�Cu�q|�g�)[z��3Iǭ�����#ۻ��¶�2P);n�~씳o��QV��9��2���eY�zY�VO�oaq����r����D�)�	W���n������6���3$�\�=s�V1���\Y6̙Z�xۖ����S*�,r���Q�g n��~f�8��Tr�:�{�龞-~2ṅ�����?�aj%�n����,���,�����Ě�m�Jl�j��ն*c�j��k�v�Y��T�.���������� #�q~A��������猰r:֭{C�|[�ƀ�v��[�Do�UؽI`Ni�f�1帮Əf&{�x�����W�Y�jP��ӎ?�ٴ�q��ǯ ��-�W�Jd�E�Iݧ_����0�H��+'���+����R�,l<����Ua��<��f�yq�q�_G�M��-�\��*������$ӽĢI3�+���_]Qf�Έ�'=���D1�/�z�%�d�ƚ!��2�%��~��q>�2ޟo�p~C�����Q�����W����1��cP�ǔ�>����a܆����u��Q�J�!mo��V���K}ěV���fL�;.��d�hk�K��Z�*��k�>�x�v%deK�(�q�I\�D{	(�?�t�+Y�b�2>.|{�����Q%S�l}l!��P���EU���B�ya���'�6����
��9�y�%����[��l�e�D�� �'�Ȩ���٣�wNl9�}�d�⇅G�_����ʲ���[�-n��6f�A�����߫�p�k�^v�yV8��[Ei����^D&�`�,��vZVԷM��
�V0ٌ�nf�Wk�*����R�#�@�TB�&%E��1�կ�����0��]�6,�N�0�FSI�}TF1v	�ښj�E=�W�!n�8�͋�?V+m�x!Z[�%�b5��H����zAFh�#a���p2�֦���P8l�A�P�*4C�6�f���`w���T���̕�jKn�i����<�Y�	���Y��2ˡ���,ơev�8Ns��n��`?�I�T��o���os-��u-�u-n��´��[+$NH`�Ԏ�;p]`½�/;��3C��˒!}I�C(�3�tT�y��>�@MC]!X������==Þ���cߟŬ?���q��?������5��Gk$���Hu⭌�A�6�:�dJ5z0OI��V[}u�U���Ih9�j� �L�U0�0S!�zؚ���|�X���.��L�=ݓ�qYWj��S��y+�Y��`���O#U����v���������3v���XvN��3�y����>���IٗeoF������Au6vv*�4.�WL偉�,�Y94��4le�F�t�M�!�]�x��Q)"�	E����f���Wk�J6;.��Uk[�Kx<>l�=E����wq� AC�0��mLy0��+W��`�����U		��i�����!�Ѫ8�u\�m�����@�r�:��h�xL�en?8��>.W;����E����r��*U����|>�=���}:%� ����5�~u�8�ձS�*R��/j���N׾qx���M��` 6��XC۴���>Z�	k����:Yl�Xh����hd���a�21���P�p����-5e���K8�����\��9GQRv�T�,\S[{G'�A�ɟףYę�z�Nn�O IX��v%��B	�����Z�tз�ze�4�h�/�u�/1>����]�1]�fA�*��l����MԬ%А��R$��pnC"��=�i@HP�x ����A`C��J1�$/>�`�/_�蟐����B�L|�Ɩ-:����קf�D]�k��h8�JGB��
�H��/O���0���1<��OhB��Q�Qbʙ��56�@���X��d,UX*�T��-�6�5��Tds<cϼ���n����M��pl�;iѼ��=2+�-gb�ӫ�4�q<�kD�N��W�Ƣ5K��UAc����*����м��C�����9Bs�ꌅ�y�8��r�[��D
H�E\�H�y�ݷ0�_֑Y�Z���Zb��qӬ�Y�K�0c[�k�&ʗ L0�A�Ag0�8.ً�I�T96�A6��(�����8��Oj����P[�ɩʅ�U���o���m1���݉�]�p&W������)+���ɺζ��e_�� a��Ɖ���6��۪�6EW�2v�j誵�u�Z���Ӷ��|e��n���d��Q�:��>PG8֣��u��\iΣt�ѹ����0��
�,��`g��Z��6�ҫ�Ÿ�K�26F���r2��H`K��K�	������`��R�ǿ*�j�ˎy�ϰs:��c� ޛ�TӪ��-�츋�~�y|ٷ�ʺ::[�]0ūL1nSL�)��Sm�Yb��T���ͩ*��Q�fƫ�|V��Zl.q��̪�̅�mf�Sf��S��Wef�,h3�3kefᗙ3���Yif��L�ʜ�ڜj����f�[�m!�r35�E��S�ɂ�l��E3Z0Ui1,�̢�,�E˚�Sf���|���fV���@6�Um�bs�K,�m��rdY��Sa!Y��jQ�E���o�n��`�-�͵�XR4��ŐYb!k�jQ#�E�{�z,��n(�ڤE�qt01UWV�,�⡻����DOEeEU���ݞ
w�G+�'S�K%��8����h8�u:H�ޞ��#~H���}n�tS,6�e�aRQa����*��e�U�*h����rAt�7#V�_���	�Gڤv�qm����^�wC]C�ڕ^��s >��nM>���x�V/�Ĥ�!|IME�KZm���3,ݤ�Y�/%/�9`�+6�3ű�C,�\mR�x�=�����U�D,�D�|�x��ɋ�ϟ,�kZ�!��/�
�I	q��ܼZ������R8���P���=�z��PX49������-���C]����t�/`�T�e��X���$��
���b����}EE�P����X2�����E� ��@"��ɜ&&�VuťEP��+-Ĉ�Y�P���Pr�4��j�D����&�� 1=`�
,�ĝ����b�b�$�H��^�{���-k����V+�G�;�uj���D�NĤ`R�{e���=�+�l����!)&�iy�IH�f��|d�!��e�H�-]�G&'�Z:���\����Ia))eLj��z�R�P��]8�r-s�g����+	ho7��������bW������ذ�;G����mt] �ʩB'�M�;I���]q.�P_��5K�#bk4��S���_�I�%1��*ľ�����@2)uƒ������}ЩD�ў���>6W��pU��
+̩�W�K�V�JX��5L�����Q,�M$�Y�V��֗IU�,e�ˠ��Q
�I��+uI�~G�V'EK��gޘ�&�S�7Z�e[VT�i�_�:n�jn�|�ie����:��W��Q�(�yy�b�WUVT���_Y��?��?��h����m��h�+F�����[*�K��fc����J�1�����ft:�+j��F.�~�h�LnY �_�/�/ �����TZ�l�G;��QL~�!�&��C	H�S!���4�#hz��*|�KZ�Sc�����>�:宝
,>�4���bS�RKr4�Z}�)��k����~��L���5��{Lmh�)���M��)��<� #$�SU����eT���%��ch�jɼ1���0�I.�b�OK[B�$��B�t<e�O1�Mv�Oo�ԗ) m��]S^�^�J�n��]oIH�.��iJeNf-~��z�6�[j���}j���)Ү�����!?�u�P�����p�Yƨ��n��ÿݞ�2�c��/����[��Ż���To�=h��;�m�5�H�Cb�^7�]�T\�V9x[�w�ݛž$գl�Z�r��%��T�*g����Ս�9[x��h�����5))�u��D��=��5�3�MgJx�6���E�vYLy�Τ�&cS����	�N���1�T�h�%$�}G�9�w���~�<��Yc�����3M�6��C�de��*F#�K[B�x�]�,�B�4F5I���c���?�Or��T{;����?�2���߈���(�F�h����b=�7/,.%�AM(r�UnPz	T5_�P���ٿ?6������ѳ���f-H�U�H��9��X��}x^�q�w��1"ci��M�f<�����Ur8v��	����7��pf��SV@9�Q^���+܎��~8��O_�7[��c���oX��j$�|�3 cY(�7��c�%	��������)��ɯ����$hG�t�{��&���X�u�NƵ��+Ÿ(�S�Ao^fHq<��~Ic��)+`�`yLA�h.��v�1����S��˪1�����ws�|�~x&��/�OZ�b���>l��D× k*���;Մ!ݖP��pG��M���B]�Z��&�HC�i,C�`�^�
��Ϝ�ͥ��ᐄ�wyhqd0Š�D�;��l�����-zױJ����?wkZ>�PZX)g���fK�K�; ә���q�Я��h*i����eFiz��ħ.Mե"��_�j,��H��pu�k���"		���Ha[��@��$e��Xc�9����,J��Ҹ	A��$�+���?P'�N�\�o]�3�SDB�ف�(�A���,z�a�� *�#��jo6ta�fՌ��k�f�SGR���h��ؑ'�����6���m3�̊zB�Y�2�c��T�c�s��L�f���N?ZZ�K{Ȝ��}>�9��Zs<�\j�c�su�ws.�c���4�l�\J|ts�e�NÜ��)��9w�0.s.��|�����8̸�At���!�9S�x'i���썖��5�$4��M�_��I�.�*��L��qd_���cb_%�D�a�>N���i����*��ǡ������˕�?U�j<�]�p���gz���i����o�ɯ�я\d�ۋ��n�Z�Պ1��K0��a*O}��ҡ����"��xX�<�nb(��s�w,���� 0�Y**b>RR~l�(v�ɮã�l���C��"alXvD>��Y�P����y�B��$/��}�m�7�𛈼�a<k�L?�a5U]���d�6�LB��x�J�@���?{{���*���_>UZw^���e̗T�Dh�mj����Gi��T��7��eh�YJ3BQ	�����B>�I��V����aJ�jE�PkXZ���-bbS4nC���MT �L�����[ڱTl�Mw�G��f]>��֌�`��oHɤB�
���	�'��D����J����Ҷ!��'��̵�"i��&6��I��nZ��m��)������T.��)��5}�]({z �ۆq���6L��%���.1XݔVǶBg���!�|����(�b�-�s}6�-^l���b1&_ʪ���O& �-�1���Dl�H'�KE�C2 q�R�	FSqh�6:��S'|L�p;%�����p��[b��˳P�E�@9�%����"�$)=Qi�y��`�2C/�� 3P�G��Z�6Βҟm�J]41�B�[L][=i��Y�ڪ#��}׮;S� �캃c�������G5Ư�Q���K��wW��_]�v���Ù���_���_��[�2%8�7@/��м�� 4$:��e͓�&H ?+��V ��rm�e�i ���K�6k�Ɣ�ڿ�fq�$,E�^#��?֮��_�2�\�Mad��J��D�_u��-�������!���Fۈ�ܿ��H-S?�0�G
�c�~��l������?�y|� M���O���yP�Wz���8���o������p*���qKQ9��L�hI���fon)����J�o��Ց-1�S����=����F-�|�/���3͵>�i!.�����K�������T�U��WV�;���/Τ����Y�}�7������1��`�Sk�ԇ��ـ=�>����&�r�;��Or.������#&�Qm�#�l�Jפa������)�
&ޑ���'�P��F I�9Z�nK+Pරx��Fii)c�"UX���;�"�y���9w�}<�Q�7�`ŵ9o���/ad�޶t��4��,~�;����"��u[^P�Pďl���sAڈP�vz�Xu,]9�NY�a�á����gt�1���SU�|���p��A��������eN��/Nm��}�Tb�{��ۿ�}��i����?�WL�R2Q�}�������l�*����*˜�?�;'��;�Ƚn���ɡ���9�խ�]�����d]��2oSs㺵�J�эk5���jos�XV��}��y���m�]���Ō�xх��ԝ>�^<o23�J�a��8�)�3�Ř��8�ʭ
�c?gY�[��`�R�e�h-/-��7�����&k�̹L��%�:c�xRl���q(
��vv�5���VX��G�WG���G3Izy��OHIy�ߺ����ժ�=�",Β�t:��e�3N�ba|Pk>��@ܼ)�$nfk<�RD��R�m+�Y�
�=z�������h\��ysP:?_���i�ۑh�.��%<KmJZvj/��l��ZWll�i�
���Jj}>��zі���omc��^Km�Jo�h	-K3	#3)��JF%��(i�@�p��T�^�l �0����t}�j;Qb�:���52��/Ķ�c��X��8�@�D��֮k�k�tu��(�@P�׷���+/+���6���S�:����BR#;��$����mƽ���M ����݃PBq�R�#>��D���x�U2,�,&�,���xݦf�2��6یƊBf���k�ޱF�V��c)���@}8�_p�uq	qc��2�{��nΰ��F�E}���]ѸAL��u뛚�k[���yǅ)�W�Zք�1�4�Qw�Ӫ�h�򒙜������Z������0���xWI:Vln�m�֋���H�Y�ٯ~�A��״��mji�6_�k[�M+`��]���&o]˺&�oQ�E�iZ�˻�q�*��ES-�F[�K��R�œ�M�PB��Sf;�[�N�]��/�c������H��8]h�T/���@�qnT`g� �	B����=iu�����[�r��劂��Y�I�to��6Ӣd�|�,1O��8�#�f�����[�DՆ�ۊ3Mz���w�;��@�E��G
���
[��]� �Fc"�D;�X�'s9��h�jߚ���V1L� �V��d�TTG'N��$��N���za[ef��!�ߠ�ӆfJ�N#�J5ߨ����|�q�vU��^	���L�fa�N�U�Ү*��3XZ��mQ�O.Lv���S�@1��������糳�,��@�>�Ҷ �ƃ?��g�����[��[� �/�F��IS��	Jm�z\[��1��
�W��Sм�ā~n	��C��;���7�8s)B��<H 4��e���52-�Lͤ� ��:>fJ��;���S�L]�uW���bnf�.5j>�>�
_�l
tI@�U�"d��L���'����;�P }�_c��f���(�M!���Ң<B�L+��jƥ-�Y��3���1Ev��?������?��*q�������y?��ܶd,s/ͼb�}�q��.��߅�h�X4�h�?***���g��/�_|o���H�{~1[���.��d�AZnU���� �њ���:K�h\����Jn׮��Ƹ�Tȭ^W�(�BVk��Pd�4�Ҷ� ��t�׭�]��P����M6�@^��VF�F$�FͣZ�j��#�{L�z�O���w����Q�y���`��W�����/�VG!<��H��ʨ�&�c"�',�ķa����6?�9K敢"e/ԧ�1"{����)��D���y�f(�/��Q��DI�*�� ��(|-�+o�<"�J���G��k�ebA�����j�ںU�+�����P[ׂ��b�WI��xO�
��m�챏@]��Hј�y�&�[��".�ClM��'k���֭�f_��kW<����e�R�m%��陮���e�V	W���pv�� �R��Yb�K,����ٶ�����qm}��&�]p\�C�h'B�X)�>LdW��=$K2P�Κ�`�a-kq�5���$	Ĕ�uM��[�a��l�ֶx�l��ݠ���u��ٗ��yl9��y�hmm/\Q���kx�8J����^�SC%'�1���fRǕ�`U�*J�Y��J[�K�<B�{�0^C��GD�(��۔��K�m��h�$ۇ����x�w�u��~��@uDpP��Ku7t)�k�Eb�+^\l|<iz�	l2+M��J�]e�n
$T�V^����5�\�/~ѝhDQؠ�H��RLH�xpTv��ժ�*���CI�PK�|M*+��!ŋ������!�
�s�!j�X2�:�m��<;
��k��7�Ԫ�G�=�;�q�s�Q���x��  