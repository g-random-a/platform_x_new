import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String initialValue;
  final List<String> items;
  final ValueChanged<String> onChanged;

  const CustomDropdown({
    Key? key,
    required this.initialValue,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  // Track the selected value and overlay visibility.
  late String selectedValue;
  OverlayEntry? overlayEntry;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  // This function will build the dropdown menu overlay.
  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width, // Match the dropdown width to the button width.
        child: CompositedTransformFollower(
          link: _layerLink,
          offset:
              Offset(0, size.height + 5), // Offset dropdown below the button.
          showWhenUnlinked: false,
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(6),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .2,
              child: ListView.builder(
                  padding: const EdgeInsets.all(6),
                  shrinkWrap: true,
                  itemCount: widget.items.length, // Adjust height to content.
                  itemBuilder: (context, index) {
                    final item = widget.items[index];
                    return ListTile(
                      title: Text(item),
                      onTap: () {
                        setState(() {
                          selectedValue = item;
                        });
                        widget.onChanged(item);
                        _removeOverlay();
                      },
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }

  void _showOverlay() {
    overlayEntry = _createOverlayEntry();
    Overlay.of(context)!.insert(overlayEntry!);
  }

  void _removeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: () {
          if (overlayEntry == null) {
            _showOverlay();
          } else {
            _removeOverlay();
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedValue,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              const Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
